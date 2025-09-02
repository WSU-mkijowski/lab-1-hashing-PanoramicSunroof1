#!/bin/bash

#usage ./minermm.sh

# loop through each word in dictionary
for word in $(cat ../data/dictionary); do
  # try nonces 1 through 10000 for each word
  for nonce in $(seq 1 10000); do
    combo="${nonce}${word}"
    hash=$(printf "%s" "$combo" | sha256sum | awk '{print $1}')

    # check if hash starts with 000
    if [[ $hash == 000* ]]; then
      echo "$hash - $combo"
    fi
  done
done
