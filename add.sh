#!/bin/bash

. "$(dirname $0)/scripts/lib/stdio"

warn 'This script is deprecated. Please use `./sc add` instead.'

./sc add $@
