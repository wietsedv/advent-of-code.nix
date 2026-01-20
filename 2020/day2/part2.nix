let
  input = builtins.filter (x: x != "") (
    builtins.split "([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)\n" (builtins.readFile ./input)
  );

  items = builtins.map (item: {
    i = builtins.fromJSON (builtins.elemAt item 0) - 1;
    j = builtins.fromJSON (builtins.elemAt item 1) - 1;
    char = builtins.elemAt item 2;
    password = builtins.elemAt item 3;
  }) input;

  charMatches =
    password: char: index:
    (builtins.substring index 1 password) == char;

  validPasswords = builtins.filter (
    item: (charMatches item.password item.char item.i) != (charMatches item.password item.char item.j)
  ) items;
in
builtins.length validPasswords
