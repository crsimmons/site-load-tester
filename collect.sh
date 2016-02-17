#!/bin/bash
[ $VERBOSE ] && set -x
set -euo pipefail

CF_APP=$1

CF_URI=$(cf app $CF_APP | awk '/^urls:/{print $2}')
TIMENOW=$(date "+%s")

mkdir -p data

for THING in report.{json,text,plot} dump.{json,csv}; do
  curl $CF_URI/$THING > data/$TIMENOW.$THING 2>/dev/null ; true
done