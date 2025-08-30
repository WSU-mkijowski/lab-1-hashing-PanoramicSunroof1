#!/bin/bash
# Usage: ./salted_hash.sh quiz_data.csv > salted-data.csv

input="$1"

# Temporary file for salts
declare -A salts

first_line=true

while IFS=, read -r name rest; do
    if $first_line; then
        # Print header untouched
        echo "$name,$rest"

	#added first_line=false to not salt / hash header
        first_line=false
        continue
    fi

    # generate a unique 5-character salt for each user if not already generated
    if [[ -z "${salts[$name]}" ]]; then
        salt=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c5)
        salts[$name]=$salt
    else
        salt=${salts[$name]}
    fi

    # prepend salt, hash, prepend salt again
    hash=$(printf "%s%s" "$salt" "$name" | sha256sum | awk '{print $1}')
    salted_hash="${salt}${hash}"

    # print salted hash + rest of line
    echo "${salted_hash},${rest}"
done < "$input"
