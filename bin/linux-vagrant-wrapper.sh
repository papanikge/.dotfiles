#!/bin/sh
# alias this to something like 'linux' and put it to PATH
pushd ~/arch-vagrant/ && vagrant $1 && popd
