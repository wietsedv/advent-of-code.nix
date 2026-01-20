let
  input = builtins.filter (x: x != "") (
    builtins.split "([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)\n" (builtins.readFile ./input)
  );

  items = builtins.map (item: {
    min = builtins.fromJSON (builtins.elemAt item 0);
    max = builtins.fromJSON (builtins.elemAt item 1);
    char = builtins.elemAt item 2;
    password = builtins.elemAt item 3;
  }) input;

  countChars =
    char: password:
    builtins.length (builtins.filter builtins.isList (builtins.split "(${char})" password));

  inRange =
    min: max: n:
    n >= min && n <= max;

  validPasswords = builtins.filter (
    item: inRange item.min item.max (countChars item.char item.password)
  ) items;
in
builtins.length validPasswords
