#!/usr/bin/env bash

set -euo pipefail

# Follows the guidelines from https://realpython.com/installing-python/#how-to-build-python-from-source-code

function setup_build_prerequisites() {
  sudo yum groupinstall -y "Development Tools"
  sudo yum install -y tar gzip wget
  sudo yum install -y gcc openssl-devel bzip2-devel libffi-devel
}

function set_aliases() {
  ln -sf "${python_installation_dir}/bin/python3" "${python_installation_dir}/bin/python"
  ln -sf "${python_installation_dir}/bin/pip3" "${python_installation_dir}/bin/pip"
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
      ./configure --prefix="${python_installation_dir}"
      make -j 8
      make install
    popd >/dev/null
  popd
  rm -rf "${temp_dir}"

  set_aliases
}

setup_python "$1" "$2"
