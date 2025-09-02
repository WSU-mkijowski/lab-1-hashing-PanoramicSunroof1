#!/bin/bash
# Usage: ./minermm.sh "word" "number of iterations"

# First arg = word, second arg = how many iterations

word="$1"
limit="$2"

for ((i=1; i<=limit; i++)); do
    input="${i}${word}"
    hash=$(echo -n "$input" | sha256sum | awk '{print $1}')
    echo "$input -> $hash"
done
