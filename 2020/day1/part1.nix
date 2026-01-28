with builtins;

let
  input = filter (x: x != [ ]) (split "\n" (readFile ./input));
  numbers = map fromJSON input;

  pair = filter (i: any (j: i + j == 2020) numbers) numbers;
in
(elemAt pair 0) * (elemAt pair 1)
