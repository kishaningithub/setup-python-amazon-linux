# setup-python-amazon-linux

[![build-test](https://github.com/kishaningithub/setup-python-amazon-linux/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/kishaningithub/setup-python-amazon-linux/actions/workflows/test.yml)

Github action to install python in all flavours of amazon linux. The goal of this action is to be a drop in replacement 
for the github's official [setup-python action](https://github.com/actions/setup-python) to the maximum extent possible.

## Why?

- This project exist because as of Nov 2023 [Github has no plans support amazon linux](https://github.com/actions/setup-python/issues/460#issuecomment-1185723652) for its official 
[setup-python](https://github.com/actions/setup-python) action for amazon linux self hosted runners.

## Implementation caveat

This action compiles the desired version of python from source for the first time because the glibc version in use in 
amazon linux 2 is very old (2.26) and the pre-made existing binary distributions fail with the following error

```yaml
python: /lib64/libc.so.6: version `GLIBC_2.27' not found
python: /lib64/libc.so.6: version `GLIBC_2.28' not found
```

Hence only for the first time this action may like 3 to 4 minutes depending on the runner configuration. Post this only cache
will be used and hence will be very fast (4 to 5 seconds)

## Supported amazon linux flavours

- Amazon Linux 2
- Amazon Linux 2023 

If you need support for more kindly raise an issue or a PR

## Usage

All you have to do is change "setup-python" to "setup-python-amazon-linux" in your workflows

```yaml
steps:
- uses: actions/checkout@v3
- uses: actions/setup-python-amazon-linux@v1
  with:
    python-version: '3.10' 
- run: python my_script.py
```

For more options to the action, kindly refer [action.yml](./action.yml)

## Contributing

Contributions are most welcome! See [CONTRIBUTING.md](./CONTRIBUTING.md)
