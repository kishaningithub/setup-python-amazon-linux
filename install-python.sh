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
  setup_build_prerequisites
  python_installation_base_dir=~/setup-python-amazon-linux/.python-versions
  python_installation_dir="${python_installation_base_dir}/${python_version}"
  mkdir -p "${python_installation_dir}"

  pushd "${python_installation_base_dir}" > /dev/null
    wget "https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tgz"
    tar -zxf "Python-${python_version}.tgz" && rm -rf "Python-${python_version}.tgz"
    pushd "Python-${python_version}" > /dev/null
      echo "before configure"
      pwd
      ls
      ./configure --enable-optimizations --prefix="${python_installation_dir}"
      make -j 8
      sudo make install
      echo "after install"
      pwd
      ls "${python_installation_dir}"
      set_aliases
    popd > /dev/null
  popd
}

setup_python "$1"
