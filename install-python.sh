#!/usr/bin/env bash

set -euo pipefail

function set_aliases() {
  ln -sf "${python_installation_dir}/bin/python3" "${python_installation_dir}/bin/python"
  ln -sf "${python_installation_dir}/bin/pip3" "${python_installation_dir}/bin/pip"
}

# Reference - https://realpython.com/installing-python/#how-to-build-python-from-source-code
function setup_python() {
  python_version="$1"
  python_installation_dir="$2"

  mkdir -p "${python_installation_dir}"
  temp_dir=$(mktemp -d)
  pushd "${temp_dir}" >/dev/null
    wget "https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tgz"
    tar -zxf "Python-${python_version}.tgz"
    pushd "Python-${python_version}" >/dev/null
      # - Have not added --enable-optimizations flag because that shoots up the build time by ~5 minutes
      # - Ref for openssl
      #     - https://gist.github.com/wizardbeard/d5b641d1fadbaba755823e16eab4dda1#file-python-3-9-slim-dockerfile-L17
      #     - https://stackoverflow.com/a/29169795/3316017
      #     - https://stackoverflow.com/a/75880038/3316017
      export OPENSSL_LIBS=/usr/lib64/libssl.so
      ./configure --prefix="${python_installation_dir}" --enable-shared --with-openssl=/usr --with-openssl-rpath=/usr/lib64
      make -j "$(nproc)"
      make install
    popd >/dev/null
  popd
  rm -rf "${temp_dir}"

  set_aliases
}

setup_python "$1" "$2"
