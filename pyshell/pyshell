#!/usr/bin/env bash

SCRIPT_DIR="$( dirname "$( readlink -f "${BASH_SOURCE[0]}" )" )"

nix-shell --argstr projectRoot "$(pwd)" "${SCRIPT_DIR}/shell.nix"
