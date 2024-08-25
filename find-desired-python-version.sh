#!/usr/bin/env bash

set -euo pipefail

specified_version="$1"
specified_version_file="$2"

desired_python_version="${specified_version}"
if [ -f "${specified_version_file}" ]; then
  desired_python_version=$(cat "${specified_version_file}")
fi

echo "${desired_python_version}"