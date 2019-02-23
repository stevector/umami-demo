#!/bin/bash

set -eo pipefail
# Set up environment variables
# By default, we will make the environment name after the circle build number.
DEFAULT_ENV=ci-$CIRCLE_BUILD_NUM

# If there is a PR number provided, though, then we will use it instead.
if [[ -n ${CIRCLE_PULL_REQUEST} ]] ; then
  PR_NUMBER=${CIRCLE_PULL_REQUEST##*/}
  DEFAULT_ENV="pr-${PR_NUMBER}"
fi

(
  echo 'export PATH=$PATH:$HOME/bin'
  echo "export DEFAULT_ENV='$DEFAULT_ENV'"
  echo 'export TERMINUS_ENV=${TERMINUS_ENV:-$DEFAULT_ENV}'
  echo 'export CYPRESS_baseUrl="https://${TERMINUS_ENV}-${TERMINUS_SITE}.pantheonsite.io/"'
) >> $BASH_ENV
source $BASH_ENV
