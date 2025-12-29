#!/usr/bin/env bash

read -p "Start: " start
read -p "End: " end

if [ "$start" -gt "$end" ]; then
  echo "Invalid range"
  exit 1
fi

even=0
odd=0

for ((i=start; i<=end; i++)); do
  echo "$i^2 = $((i * i))"
  if (( i % 2 == 0 )); then
    even=$((even + 1))
  else
    odd=$((odd + 1))
  fi
done

echo "Even count: $even"
echo "Odd count: $odd"
