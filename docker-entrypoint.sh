#!/bin/sh
set -e

#mkdir -p ${NPM_CONFIG_PREFIX} 

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- "$@"
fi

exec "$@"
