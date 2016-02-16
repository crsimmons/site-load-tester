#!/bin/bash

: ${DURATION:=60s}
: ${RATE_PS:=5}
: ${TARGET_FILE:=urls.txt}
: ${KEEPALIVE:=true}
: ${REPORTS:=text json plot}

./vegeta attack \
  -duration=$DURATION \
  -rate=$RATE_PS \
  -targets=$TARGET_FILE \
  -keepalive=$KEEPALIVE \
> results.bin

for REPORT in $REPORTS; do
  cat results.bin \
  | ./vegeta report -reporter=$REPORT \
  > public/report.$REPORT
done
