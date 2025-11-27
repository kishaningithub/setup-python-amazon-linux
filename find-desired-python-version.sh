#!/usr/bin/env bash

set -euo pipefail

specified_version="$1"
specified_version_file="$2"

desired_python_version="${specified_version}"

if [[ -z "${desired_python_version}" && -f "${specified_version_file}" ]]; then
  desired_python_version=$(cat "${specified_version_file}")
fi

if [[ -z "${desired_python_version}" ]]; then
  echo "❌ error: Both inputs .python-version and .python-version-file are not given. Kindly provide one of them." >&2
  exit 1
fi

echo "${desired_python_version}"