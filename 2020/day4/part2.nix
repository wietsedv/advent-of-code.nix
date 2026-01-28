with builtins;

let
  input = filter (x: x != [ ]) (split "\n\n" (readFile ./input));

  fields = {
    "byr" = (val: fromJSON val >= 1920 && fromJSON val <= 2002);
    "iyr" = (val: fromJSON val >= 2010 && fromJSON val <= 2020);
    "eyr" = (val: fromJSON val >= 2020 && fromJSON val <= 2030);
    "hgt" = (
      val:
      let
        matches = match "([0-9]+)(.*)" val;
        num = fromJSON (head matches);
        unit = elemAt matches 1;
      in
      if unit == "cm" then (num >= 150 && num <= 193) else (num >= 59 && num <= 76)
    );
    "hcl" = (val: (match "#[0-9a-f]{6}" val) != null);
    "ecl" = (
      val:
      elem val [
        "amb"
        "blu"
        "brn"
        "gry"
        "grn"
        "hzl"
        "oth"
      ]
    );
    "pid" = (val: stringLength val == 9);
  };

  validate = field: x: x != null && fields.${field} (head x);

  hasValid = field: x: validate field (match ".*${field}:([^ \n]+).*" x);

  checks = map (x: all (field: hasValid field x) (attrNames fields)) input;
in
length (filter (x: x) checks)
