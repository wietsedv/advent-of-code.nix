with builtins;

let
  input = filter (x: x != "") (split "([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)\n" (readFile ./input));

  items = map (item: {
    min = fromJSON (elemAt item 0);
    max = fromJSON (elemAt item 1);
    char = elemAt item 2;
    password = elemAt item 3;
  }) input;

  countChars = char: password: length (filter isList (split "(${char})" password));

  inRange =
    min: max: n:
    n >= min && n <= max;

  validPasswords = filter (
    item: inRange item.min item.max (countChars item.char item.password)
  ) items;
in
length validPasswords
