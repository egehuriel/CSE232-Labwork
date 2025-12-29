#!/usr/bin/env bash

read -p "Enter a number: " num

sum=0
i=1

while [ "$i" -le "$num" ]; do
  sum=$((sum + i))
  i=$((i + 1))
done

echo "Sum from 1 to $num: $sum"

if [ "$sum" -gt 100 ]; then
  echo "Sum > 100, divided by 5: $((sum / 5))"
else
  echo "Sum is small, no further action"
fi
