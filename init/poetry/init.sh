#! /bin/bash

export PATH="${HOME}/.poetry/bin:${PATH}"

# set virtualenvs to be created in project
poetry config virtualenvs.in-project true
