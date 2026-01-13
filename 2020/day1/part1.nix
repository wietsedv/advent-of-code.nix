let
  input = builtins.filter (x: x != [ ]) (builtins.split "\n" (builtins.readFile ./input));
  numbers = builtins.map builtins.fromJSON input;

  pair = builtins.filter (i: builtins.any (j: i + j == 2020) numbers) numbers;
in
(builtins.elemAt pair 0) * (builtins.elemAt pair 1)
