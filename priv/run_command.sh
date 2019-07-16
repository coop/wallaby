#!/bin/sh
export DISPLAY=:99
Xvfb $DISPLAY -screen 0 1024x768x16 &

"$@" &
pid=$!
while read line ; do
  :
done
pgid=$(ps xao pid,pgid | grep $pid | awk '{print $2}')
kill -9 -$pgid
