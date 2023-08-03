#!/bin/bash

_anyenv_init() {
  eval "$(anyenv init -)"
}

eval "$(lazyenv.load _anyenv_init anyenv)"
