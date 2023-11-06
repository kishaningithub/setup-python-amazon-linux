# Contributing

## Context

This action is built as a composite action, for more details kindly refer
- https://docs.github.com/en/actions/creating-actions/creating-a-composite-action

## Code setup

- The code is primarily bash scripts, hence feel free to look into scripts and hack away!

## Adding support for new python versions

- The exact python version to install is actually resolved in [find-exact-python-version.sh](./find-exact-python-version.sh) shell script. Kindly add it there.
- Add test cases to [test workflow](./.github/workflows/test.yml) when necessary.
