#!/usr/bin/env bash

set -euo pipefail

# Reference https://stackoverflow.com/a/73208851/3316017

sudo yum update -y

desired_openssl_package="openssl-devel"
if yum info "openssl11-devel" &>/dev/null; then
  desired_openssl_package="openssl11-devel"
fi

desired_lib_crypt="libcrypt"
if yum info "libxcrypt-compat" &>/dev/null; then
  desired_lib_crypt="libxcrypt-compat"
fi

dynamic_package_list="${desired_openssl_package} ${desired_lib_crypt}"

sudo yum install -y autoconf automake binutils bison byacc cscope ctags diffstat doxygen \
  elfutils flex gcc gcc-c++ gcc-gfortran gettext git indent intltool libtool make patch patchutils \
  pkgconfig rpm-build rpm-sign swig system-rpm-config systemtap  \
  ${dynamic_package_list} zlib-devel bzip2 bzip2-devel readline-devel libffi-devel \
  ncurses-devel sqlite sqlite-devel gdbm-devel tk-devel xz-devel \
  tar gzip wget which
