#!/usr/bin/env bash

BASE="$HOME/Labwork8"
DATA="$BASE/Data"

if [ ! -d "$DATA" ]; then
  mkdir -p "$DATA"
fi

ls "$BASE"
ls -d "$BASE"/*/

count=$(find "$BASE" -maxdepth 1 -type d | tail -n +2 | wc -l)
echo "Subdirectory count: $count"

cd "$DATA" || exit
pwd

cat > info.txt << EOF
Stay curious.
Keep building.
Mistakes teach more than success.
Consistency beats motivation.
Small steps matter.
You are improving.
EOF

grep "Keep" info.txt > "$BASE/keywords.txt"

head -n 1 info.txt > "$BASE/summary.txt"
tail -n 1 info.txt >> "$BASE/summary.txt"
wc -w info.txt >> "$BASE/summary.txt"

mv info.txt myQuotes.txt
chmod 755 myQuotes.txt
