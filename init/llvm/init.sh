#!/bin/bash

llvm_prefix=$(brew --prefix llvm)
export PATH="${PATH}:${llvm_prefix}/bin"
