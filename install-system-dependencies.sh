#!/usr/bin/env bash

set -euo pipefail

# Reference https://stackoverflow.com/a/73208851/3316017

sudo yum update -y
sudo yum groupinstall -y "Development Tools"
if yum info "openssl11-devel" &> /dev/null; then
  sudo yum install -y openssl11-devel
else
  sudo yum install -y openssl-devel
fi
sudo yum install -y zlib-devel bzip2 bzip2-devel readline-devel libffi-devel \
                    ncurses-devel sqlite sqlite-devel gdbm-devel tk-devel xz-devel \
                    tar gzip wget
