with builtins;

let
  input = filter (x: x != [ ]) (split "\n" (readFile ./input));
  numbers = map fromJSON input;

  triple = filter (i: any (j: any (k: i + j + k == 2020) numbers) numbers) numbers;
in
foldl' (i: j: i * j) 1 triple
