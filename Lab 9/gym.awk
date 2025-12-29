#!/bin/awk -f
BEGIN { FS="," }

{
  split($4, d, "/")
  if (d[2] != "02" || d[3] != "2024") next

  isStudent = (index($1, "STD") == 1)  # memberID prefix
  if (isStudent) student[$5]++
  else professional[$5]++
}

END {
  print "Student Activities:"
  print "GYM:",  (student["GYM"]  ? student["GYM"]  : 0)
  print "YOGA:", (student["YOGA"] ? student["YOGA"] : 0)
  print "SWIM:", (student["SWIM"] ? student["SWIM"] : 0)

  print "Professional Activities:"
  print "GYM:",  (professional["GYM"]  ? professional["GYM"]  : 0)
  print "YOGA:", (professional["YOGA"] ? professional["YOGA"] : 0)
  print "SWIM:", (professional["SWIM"] ? professional["SWIM"] : 0)
}
