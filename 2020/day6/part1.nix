with builtins;

let
  input = filter (x: x != [ ]) (split "\n\n" (readFile ./input));

  groups = map (group: filter (x: x != [ ]) (split "\n" group)) input;

  strToSet =
    s:
    genList (p: {
      name = substring p 1 s;
      value = 1;
    }) (stringLength s);

  lengths = map (group: length (attrNames (listToAttrs (concatMap strToSet group)))) groups;

  sum = foldl' (x: y: x + y) 0;
in
sum lengths
