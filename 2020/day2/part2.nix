with builtins;

let
  input = filter (x: x != "") (split "([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)\n" (readFile ./input));

  items = map (item: {
    i = fromJSON (elemAt item 0) - 1;
    j = fromJSON (elemAt item 1) - 1;
    char = elemAt item 2;
    password = elemAt item 3;
  }) input;

  charMatches =
    password: char: index:
    (substring index 1 password) == char;

  validPasswords = filter (
    item: (charMatches item.password item.char item.i) != (charMatches item.password item.char item.j)
  ) items;
in
length validPasswords
