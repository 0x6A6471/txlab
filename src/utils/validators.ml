let is_hex string =
  String.for_all
    (function
      | '0' .. '9' | 'A' .. 'F' | 'a' .. 'f' -> true
      | _ -> false)
    string
;;

let is_base64 string =
  let len = String.length string in
  len mod 4 = 0
  && String.for_all
       (function
         | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '+' | '/' | '=' -> true
         | _ -> false)
       string
  &&
  let rec valid_padding i =
    if i < 0 then true else if string.[i] = '=' then valid_padding (i - 1) else i >= len - 3
  in
  valid_padding (len - 1)
;;
