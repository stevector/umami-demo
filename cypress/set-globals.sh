#!/bin/bash

set -eo pipefail
(
  echo 'export TERMINUS_ENV="pr-${PR_NUMBER}"'
  echo 'export CYPRESS_baseUrl="https://${TERMINUS_ENV}-${TERMINUS_SITE}.pantheonsite.io/"'
) >> $BASH_ENV
source $BASH_ENV
