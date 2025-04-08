#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"
VERSIONS_FILE=$(pwd)/versions.json

[ -f "$VERSIONS_FILE" ] # run "versions.sh" first

# Generate warning "PLEASE DO NOT EDIT IT DIRECTLY"
generated_warning() {
    cat <<-EOH
#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
EOH
}

# Make sure that program ".jq-template.awk" is installed
jqt='.jq-template.awk'
if [ -n "${BASHBREW_SCRIPTS:-}" ]; then
    jqt="$BASHBREW_SCRIPTS/jq-template.awk"
elif [ "$BASH_SOURCE" -nt "$jqt" ]; then
    # https://github.com/docker-library/bashbrew/blob/master/scripts/jq-template.awk
    wget -qO "$jqt" 'https://github.com/docker-library/bashbrew/raw/9f6a35772ac863a0241f147c820354e4008edf38/scripts/jq-template.awk'
fi

# If you do not specify any version as argument, all parsed versions will be used as argument
if [ "$#" -eq 0 ]; then
    versions="$(jq -r 'map(.php) | join(" ")' versions.json)"
    eval "set -- $versions"
fi

for version; do
    export version # "8.0", etc
    echo $version

    unit_versions=$(jq -r --arg php "$version" '.[] | select(.php == $php) | .units[]' "$VERSIONS_FILE")
    if [ -z "$unit_versions" ]; then
        continue
    fi

    if [ -d "$version" ]; then
        echo "deleting $version ..."
        rm -rf "$version"
    fi

    for unit_version in $unit_versions; do
        unit_minor_version="$(echo "$unit_version" | cut -d. -f1,2)"
        target_dir="$version/unit-$unit_minor_version"
        export unit_version
        export from="unit:$unit_version-php$version"
        echo "generate $target_dir ..."
        mkdir -p "$target_dir"
        {
            generated_warning
            gawk -f "$jqt" "Dockerfile.gtpl"
        } > "$target_dir/Dockerfile"
    done
done
