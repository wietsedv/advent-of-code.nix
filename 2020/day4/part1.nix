with builtins;

let
  input = filter (x: x != [ ]) (split "\n\n" (readFile ./input));

  fields = [
    "byr"
    "iyr"
    "eyr"
    "hgt"
    "hcl"
    "ecl"
    "pid"
  ];

  contains = field: x: match ".*${field}:.*" x != null;

  checks = map (x: all (field: contains field x) fields) input;
in
length (filter (x: x) checks)
