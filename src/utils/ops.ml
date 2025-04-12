let is_op_code value = Js.typeof value == "string" && Js.String.startsWith ~prefix:"OP_" value

let get_script_type_from_asm asm_string =
  let parts = String.split_on_char ' ' asm_string in
  match List.length parts with
  | 2 -> begin
    match List.nth parts 0 with
    | "OP_0" ->
      if List.nth parts 1 |> String.length = 64
      then "p2wsh"
      else if List.nth parts 1 |> String.length = 40
      then "p2wpkh"
      else "unknown"
    | "OP_1" -> if List.nth parts 1 |> String.length = 64 then "p2wsh" else "unknown"
    | _ -> if List.nth parts 1 = "OP_CHECKSIG" then "p2pk" else "unknown"
  end
  | 3 -> begin
    match List.nth parts 0 with
    | _ ->
      if List.nth parts 0 = "OP_HASH160"
         && List.nth parts 2 = "OP_EQUAL"
         && List.nth parts 1 |> String.length = 40
      then "p2sh"
      else "unknown"
  end
  | 5 -> begin
    match List.nth parts 0 with
    | _ ->
      if List.nth parts 0 = "OP_DUP"
         && List.nth parts 1 = "OP_HASH160"
         && List.nth parts 3 = "OP_EQUALVERIFY"
         && List.nth parts 4 = "OP_CHECKSIG"
         && List.nth parts 2 |> String.length = 40
      then "p2pkh"
      else "unknown"
  end
  | _ -> begin
    if List.length parts >= 4 && List.nth parts (List.length parts - 1) = "OP_CHECKSIG"
    then "p2ms"
    else "unknown"
  end
;;
