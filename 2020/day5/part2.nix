with builtins;

let
  input = filter (x: x != [ ]) (split "\n" (readFile ./input));

  charIsOne = char: if char == "B" || char == "R" then 1 else 0;
  strToBin = x: genList (i: charIsOne (substring i 1 x)) (stringLength x);

  pow = base: exp: if exp == 0 then 1 else base * pow base (exp - 1);

  binToDec = bin: genList (i: (pow 2 (length bin - i - 1)) * elemAt bin i) (length bin);
  binaryToDecimal = bin: foldl' (d: n: d + n) 0 (binToDec bin);

  seatIds = map (x: binaryToDecimal (strToBin x)) input;

  missingSeat = foldl' (prev: next: if next - prev > 0 then prev else next + 1) (head seatIds) (
    sort lessThan seatIds
  );
in
missingSeat
