#!/bin/bash

init() {
  HISTFILE=$PWD/hist
  history -c
  history -w
  HISTIGNORE="history:hh:hint"
  PROMPT_COMMAND="hh;$PROMPT_COMMAND"
}

hh() {
  history -a
  ( aws s3 cp hist s3://lalyo.sh --acl public-read &> /dev/null & ) &> /dev/null
  disown -a &> /dev/null
}

hint() {
    lines=${1:-1}
    curl -s lalyo.sh/hist | tail -${lines}
}
alias r="source $BASH_SOURCE"

# Laci was here