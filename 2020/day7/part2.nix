with builtins;

let
  input = filter (x: x != "") (
    split "([a-z]+ [a-z]+) bags contain ([^\n]+) bags?\.\n" (readFile ./input)
  );

  splitBags = s: if s == "no other" then [ ] else filter (x: x != [ ]) (split " bags?, " s);

  bagMap = listToAttrs (
    map (row: {
      name = elemAt row 0;
      value = splitBags (elemAt row 1);
    }) input
  );

  countSubbags =
    subbag:
    let
      m = match "([0-9]+) (.*)" subbag;
    in
    (fromJSON (elemAt m 0)) * (1 + countBags (elemAt m 1));

  countBags = bag: foldl' (count: subbag: count + (countSubbags subbag)) 0 bagMap.${bag};
in
countBags "shiny gold"
