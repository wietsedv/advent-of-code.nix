with builtins;

let
  input = filter (x: x != "") (
    split "([a-z]+ [a-z]+) bags contain [0-9]? ?([^\n]+) bags?\.\n" (readFile ./input)
  );

  splitBags = s: if s == "no other" then [ ] else filter (x: x != [ ]) (split " bags?, [0-9] " s);

  bagMap = listToAttrs (
    map (row: {
      name = elemAt row 0;
      value = splitBags (elemAt row 1);
    }) input
  );

  containsShinyGold =
    bag:
    let
      subbags = bagMap.${bag};
    in
    if any (x: x == "shiny gold") subbags then true else any containsShinyGold subbags;

  bags = filter containsShinyGold (attrNames bagMap);
in
length bags
