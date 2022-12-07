#!/usr/bin/env bash
set -Eeuo pipefail

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

# Get "versions.json" first
if [ ! -f versions.json ]; then
    wget -qO versions.json 'https://raw.githubusercontent.com/docker-library/php/master/versions.json'
fi

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
    versions="$(jq -r 'keys | map(@sh) | join(" ")' versions.json)"
    eval "set -- $versions"
fi

for version; do
    if [[ ${version:(-3)} == "-rc" ]]; then
        echo "skipped $version ..."
        continue
    fi

    export version # "8.0", etc

    if [ -d "$version" ]; then
        rm -rf "$version"
    fi

    if jq -e '.[env.version] | not' versions.json > /dev/null; then
        echo "deleting $version ..."
        continue
    fi

    echo "generate $version ..."
    mkdir -p "$version/unit"
    cp "docker-entrypoint.sh" "$version/unit/"
    {
        generated_warning
        gawk -f "$jqt" "Dockerfile-debian.gtpl"
    } > "$version/unit/Dockerfile"

    mkdir -p "$version/unit-alpine"
    cp "docker-entrypoint.sh" "$version/unit-alpine/"
    {
        generated_warning
        gawk -f "$jqt" "Dockerfile-alpine.gtpl"
    } > "$version/unit-alpine/Dockerfile"
done
