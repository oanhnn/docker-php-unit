#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
VERSIONS_FILE=$(pwd)/versions.json

# Get all image tags from Docker Hub (process paging).
# Filter image tags by ^[0-9].*-php.*$
# Parse Unit version and PHP version from image tags
get_versions() {
    local api_url="https://hub.docker.com/v2/namespaces/library/repositories/unit/tags?page_size=100"
    local all_results="[]"
    local response
    local page_results

    while [ -n "$api_url" ]; do
        response=$(wget -q -O - "$api_url")

        # Add results
        page_results=$(echo "$response" | jq '.results')
        all_results=$(jq -s 'add' <(echo "$all_results") <(echo "$page_results"))

        # Check next page
        api_url=$(echo "$response" | jq -r '.next')
        [[ "$api_url" == "null" ]] && api_url=""
    done

    # export to JSON file
    echo "$all_results" | jq -r '
map(select(.name | test("^[0-9]+\\.[0-9]+\\.[0-9]+-php[0-9.]+$")) | { unit: (.name | split("-")[0]), php: (.name | sub(".*-php"; "")) })
| group_by(.php)
| map({ (.[0].php|tostring): {
    php: .[0].php,
    units: (
        group_by(.unit|split(".")[:2]|join("."))
        | map(
            max_by( .unit | split(".") | map(tonumber))
            | .unit
        )
    )
}})
| add
' > $1
}

# Get "versions.json" first
if [ ! -f "${VERSIONS_FILE}" ]; then
    get_versions "${VERSIONS_FILE}"
fi
