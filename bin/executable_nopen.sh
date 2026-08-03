#!/usr/bin/env bash

# nopen v0.02
#
# Copyright (c) 2020-2025 Kristofer Berggren
# All rights reserved.
#
# nopen is distributed under the MIT license.

usage() {
    echo "usage: nopen <FILEPATH> [FILEPATHS...]"
    echo "   or: nopen --type <FILEPATH>"
}

if [[ "${1}" == "" ]]; then
    usage
    exit 1
elif [[ "${1}" == "--type" ]] && [[ -f "${2}" ]]; then
    echo $(file --mime-type -b "${2}")
    exit 0
elif [[ ! -f "${1}" ]]; then
    usage
    exit 1
fi

FIRSTFILE="${1}"
MIME="$(file --mime-type -b "${FIRSTFILE}")" # ex: text/plain
PROG=""

# Map type (ex: image/*) or subtype (ex: image/png) to desired program
case "${MIME}" in
image/*)
    PROG="nsxiv"
    ;;
video/*)
    PROG="mpv"
    ;;
esac

# Fallback / default open command
if [ "${PROG}" == "" ]; then
    if [[ "$(uname)" == "Darwin" ]]; then
        PROG="open -Wn"
    else
        PROG="gio"
    fi
fi

${PROG} "${@}"

exit ${?}
