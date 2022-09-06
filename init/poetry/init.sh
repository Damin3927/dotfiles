#! /bin/bash

append_to_path "${HOME}/.local/bin"

# set virtualenvs to be created in project
poetry config virtualenvs.in-project true
