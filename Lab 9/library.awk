#!/bin/awk -f
BEGIN { FS="," }

{
  split($4, d, "/")
  if (d[2] != "03" || d[3] != "2024") next

  isFiction = (index($1, "FIC") == 1)   # bookID prefix
  isStudent = ($5 == "STD")            # user_type

  if (isStudent) {
    if (isFiction) std_fic++; else std_non++;
  } else { # assume FAC for the rest
    if (isFiction) fac_fic++; else fac_non++;
  }
}

END {
  print "Students borrowed:"
  print "Fiction Books:", (std_fic ? std_fic : 0)
  print "Non-Fiction Books:", (std_non ? std_non : 0)
  print "Faculty borrowed:"
  print "Fiction Books:", (fac_fic ? fac_fic : 0)
  print "Non-Fiction Books:", (fac_non ? fac_non : 0)
}
