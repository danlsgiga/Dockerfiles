#/bin/bash
set -e

salt-master -d
salt-minion -d

exec "$@"
