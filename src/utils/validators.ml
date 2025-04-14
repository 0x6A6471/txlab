let is_hex string =
  String.for_all
    (function
      | '0' .. '9' | 'A' .. 'F' | 'a' .. 'f' -> true
      | _ -> false)
    string
;;

let is_base64_psbt string =
  (* PSBT magic bytes *)
  String.length string >= 6
  && String.sub string 0 6 = "cHNidP"
  &&
  let len = String.length string in
  len mod 4 = 0
  && String.for_all
       (function
         | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '+' | '/' | '=' -> true
         | _ -> false)
       string
  &&
  (* padding can only appear at the end and be at most 2 characters *)
  let padding_count =
    if len >= 2 && string.[len - 1] = '=' && string.[len - 2] = '='
    then 2
    else if len >= 1 && string.[len - 1] = '='
    then 1
    else 0
  in
  (* Verify no '=' characters appear except at the end *)
  padding_count = 0 || String.index_from_opt string 0 '=' = Some (len - padding_count)
;;
