let
  input = builtins.filter (x: x != [ ]) (builtins.split "\n" (builtins.readFile ./input));
  numbers = builtins.map builtins.fromJSON input;

  triple = builtins.filter (
    i: builtins.any (j: builtins.any (k: i + j + k == 2020) numbers) numbers
  ) numbers;
in
builtins.foldl' (i: j: i * j) 1 triple
