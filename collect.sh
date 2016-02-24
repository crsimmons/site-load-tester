#!/bin/bash
[ $VERBOSE ] && set -x
set -euo pipefail

CF_APP=$1

CF_URI=$(cf app $CF_APP | awk '/^urls:/{print $2}')
TIMENOW=$(date "+%s")

mkdir -p data

for REPORT in report.{json,text,plot} dump.{json,csv} plot.html; do
  curl $CF_URI/$REPORT > data/$TIMENOW.$REPORT 2>/dev/null ; true
done