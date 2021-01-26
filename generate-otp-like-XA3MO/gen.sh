#!/bin/sh

# generates 4 random non-repeating letters with 1 random number in the middle
# examples: AB1CD EF2GH IJ2KL

< <(tr -dc '[:upper:]' < /dev/urandom | fold -w1 | awk '!s[$0]++ && ++c; c == 4 { exit }' | tr '\n' ' ') read a b c d
< <(tr -dc '[:digit:]' < /dev/urandom | head -c1) read n
echo $a$b$n$c$d
