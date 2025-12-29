#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
  echo "Usage: ./compare_and_cubes.sh <number1> <number2>"
  exit 1
fi

a=$1
b=$2

if [ "$a" -gt "$b" ]; then
  echo "$a is larger"
elif [ "$a" -lt "$b" ]; then
  echo "$b is larger"
else
  echo "They are equal"
fi

for i in {1..5}; do
  echo "Cube($i) = $((i * i * i))"
done

i=6
while [ "$i" -le 10 ]; do
  echo "Cube($i) = $((i * i * i))"
  i=$((i + 1))
done
