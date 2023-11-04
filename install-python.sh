#!/usr/bin/env bash

set -euo pipefail

# Follows the guidelines from https://realpython.com/installing-python/#how-to-build-python-from-source-code

function setup_build_prerequisites() {
  sudo yum groupinstall -y "Development Tools"
  sudo yum install -y wget gcc openssl-devel bzip2-devel libffi-devel
}

function setup_python() {
  python_version="$1"
  setup_build_prerequisites
  python_installation_dir=~/setup-python-amazon-linux/.python-versions
  mkdir -p "${python_installation_dir}"

  pushd "${python_installation_dir}" > /dev/null
    wget "https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tgz"
    tar -zxf "Python-${python_version}.tgz"
    pushd "Python-${python_version}" > /dev/null
      echo "before configure"
      pwd
      ls
      ./configure --enable-optimizations --prefix=.
      make -j 8
      sudo make install
      echo "after install"
      pwd
      ls
      pip3=`which pip3`
      sudo ln -sf $pip3 `dirname $pip3`/pip
    popd > /dev/null
  popd
}

setup_python "$1"
