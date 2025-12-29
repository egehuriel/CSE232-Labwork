#!/usr/bin/env bash


if [ "$#" -ne 1 ]; then
  echo "Usage: ./even_odd_factorial.sh <number>"
  exit 1
fi

num=$1


if (( num % 2 == 0 )); then
  echo "$num is even"
else
  echo "$num is odd"
fi

i=1
fact=1
while [ "$i" -le "$num" ]; do
  fact=$((fact * i))
  echo "$i! = $fact"
  i=$((i + 1))
done

# sum evens and odds using for loop
even_sum=0
odd_sum=0
for ((i=1; i<=num; i++)); do
  if (( i % 2 == 0 )); then
    even_sum=$((even_sum + i))
  else
    odd_sum=$((odd_sum + i))
  fi
done

echo "Sum of evens: $even_sum"
echo "Sum of odds: $odd_sum"
