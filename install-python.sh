#!/usr/bin/env bash

set -euo pipefail

# Follows the guidelines from https://realpython.com/installing-python/#how-to-build-python-from-source-code

function setup_build_prerequisites() {
  sudo yum groupinstall -y "Development Tools"
  sudo yum install -y wget gcc openssl-devel bzip2-devel libffi-devel
}

function set_aliases() {
  pip3=$(which pip3)
  sudo ln -sf "${pip3}" "$(dirname "${pip3}")/pip"
}

function setup_python() {
  python_version="$1"
  python_installation_dir="$2"

  setup_build_prerequisites
  mkdir -p "${python_installation_dir}"
  temp_dir=$(mktemp -d)
  pushd "${temp_dir}" >/dev/null
    wget "https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tgz"
    tar -zxf "Python-${python_version}.tgz"
    pushd "Python-${python_version}" >/dev/null
      ./configure --enable-optimizations --prefix="${python_installation_dir}"
      make -j 8
      sudo make install
    popd >/dev/null
  popd
  rm -rf "${temp_dir}"
}

setup_python "$1" "$2"
