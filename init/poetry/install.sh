#! /bin/bash

curl -sSL https://install.python-poetry.org | python3 -

# set virtualenvs to be created in project
poetry config virtualenvs.in-project true
