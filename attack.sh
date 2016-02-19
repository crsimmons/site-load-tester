#!/bin/bash

: ${DURATION:=60s}
: ${RATE_PS:=5}
: ${TARGET_FILE:=urls.txt}
: ${KEEPALIVE:=true}
: ${REPORTS:=text json plot}
: ${DUMPS:=csv json}
: ${COMPONENT_DIR:=components}

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

for DUMP in $DUMPS; do
  cat results.bin \
  | ./vegeta dump -dumper=$DUMP \
  > public/dump.$DUMP
done

sed -i.orig \
  '1s/^/\[/;
   1!s/^/,/;
   $s/$/\]/' \
   public/dump.json

cat $COMPONENT_DIR/plot_start.html \
    public/dump.json \
    $COMPONENT_DIR/plot_script.js \
    $COMPONENT_DIR/plot_end.html \
    > plot.html
mv plot.html public/

mv results.bin public/
