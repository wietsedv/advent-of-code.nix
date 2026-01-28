with builtins;

let
  input = filter (x: x != [ ]) (split "\n" (readFile ./input));

  w = stringLength (head input);
  mod = x: y: x - (x / y * y);

  positions =
    right: down:
    genList (
      p: if mod p down == 0 then substring (mod (p / down * right) w) 1 (elemAt input p) else "X"
    ) (length input);
  numTrees = right: down: length (filter (x: x == "#") (positions right down));
in
(numTrees 1 1) * (numTrees 3 1) * (numTrees 5 1) * (numTrees 7 1) * (numTrees 1 2)
