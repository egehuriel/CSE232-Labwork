#!/bin/awk -f
BEGIN { FS="," }

{
  # date = day/month/year in $4
  split($4, d, "/")
  if (d[3] != "2017") next

  if (index($1, "std") == 1) students++
  else if (index($1, "ins") == 1) instructors++
}

END {
  print "Students:", (students ? students : 0)
  print "Instructors:", (instructors ? instructors : 0)
}
