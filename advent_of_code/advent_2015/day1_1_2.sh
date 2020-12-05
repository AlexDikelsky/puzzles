#!/bin/bash

# First arg is filename of input
echo "$(grep -o '(' $1 | wc -l) - $(grep -o ')' $1 | wc -l)" | bc

echo "$(grep -o '[()]' $1)" | awk '
    /\(/ { n += 1;} /\)/ { n -= 1; if (n == -1) { print NR } }' | head -n 1
