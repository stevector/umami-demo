#!/bin/bash

set -eo pipefail
(
  echo 'export CYPRESS_baseUrl="https://pr-${CIRCLE_PULL_REQUEST##*/}-${TERMINUS_SITE}.pantheonsite.io/"'
) >> $BASH_ENV
source $BASH_ENV
