#!/bin/bash

TMP_FILE=/tmp/inet_up

no_inet_action(){
  shutdown -r now
}

if ping -c2 google.de; then
  echo 1 > $TMP_FILE
else
  [[ `cat $TMP_FILE` == 0 ]] && no_inet_action || echo 0 > $TMP_FILE
fi
