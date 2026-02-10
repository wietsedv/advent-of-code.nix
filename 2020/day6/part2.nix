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

  sets = map (
    group:
    length (
      filter (values: length values == length group) (
        attrValues (zipAttrsWith (name: values: values) (map (s: listToAttrs (strToSet s)) group))
      )
    )
  ) groups;

  sum = foldl' (x: y: x + y) 0;
in
sum sets
