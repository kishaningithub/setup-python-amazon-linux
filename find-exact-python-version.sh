#!/usr/bin/env bash

set -euo pipefail

specified_version="$1"

# This versions map should be kept in sync with
# - https://www.python.org/downloads/
# - https://devguide.python.org/versions/
case "${specified_version}" in
    "3")
        echo "3.12.0"
        ;;
    "3.12")
        echo "3.12.0"
        ;;
    "3.11")
        echo "3.11.6"
        ;;
    "3.10")
        echo "3.10.13"
        ;;
    "3.9")
        echo "3.9.18"
        ;;
    "3.8")
        echo "3.8.18"
        ;;
    *)
        echo "${specified_version}"
        ;;
esac
