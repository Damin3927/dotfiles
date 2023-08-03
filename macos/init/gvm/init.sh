#!/bin/bash

_gvm_init() {
  source "${HOME}/.gvm/scripts/gvm"
}

eval "$(lazyenv.load _gvm_init gvm)"
