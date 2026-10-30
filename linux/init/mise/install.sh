#!/bin/bash

set -eu

# Installs to ~/.local/bin and checks the download's checksum; no sudo needed.
curl -fsSL https://mise.run | sh
