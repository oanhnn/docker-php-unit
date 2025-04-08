#!/usr/bin/env bash
set -Eeuo pipefail

dirs=$(echo */*)
json='{"include":[]}'

for dir in $dirs; do
    version=${dir%/*}
    variant=${dir##*/}

    export version

    experimental=false
    if [[ ${version:(-3)} == "-rc" ]]; then
        experimental=true
    fi

    json=$(echo $json | jq '.include[.include|length] |= {"php": "'"$version"'", "variant": "'"$variant"'", "experimental": "'"$experimental"'"}')
done

echo $json
