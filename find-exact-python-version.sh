#!/usr/bin/env bash

set -euo pipefail

specified_version="$1"
specified_version_file="$2"

desired_python_version="${specified_version}"
if [ -f "${specified_version_file}" ]; then
  desired_python_version=$(cat "${specified_version_file}")
fi

# This versions map should be kept in sync with
# - https://www.python.org/downloads/
# - https://devguide.python.org/versions/
case "${desired_python_version}" in
    "3")
        echo "3.12.4"
        ;;
    "3.12")
        echo "3.12.4"
        ;;
    "3.11")
        echo "3.11.9"
        ;;
    "3.10")
        echo "3.10.14"
        ;;
    "3.9")
        echo "3.9.19"
        ;;
    "3.8")
        echo "3.8.19"
        ;;
    *)
        echo "${desired_python_version}"
        ;;
esac
