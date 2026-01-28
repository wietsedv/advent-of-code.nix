with builtins;

let
  input = filter (x: x != [ ]) (split "\n" (readFile ./input));

  w = stringLength (head input);
  mod = x: y: x - (x / y * y);

  positions = genList (p: substring (mod (p * 3) w) 1 (elemAt input p)) (length input);
in
length (filter (x: x == "#") positions)
