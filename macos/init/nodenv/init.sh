#!/bin/bash

_nodenv_init() {
  eval "$(nodenv init -)"
}

eval "$(lazyenv.load _nodenv_init nodenv node npm yarn pnpm)"
