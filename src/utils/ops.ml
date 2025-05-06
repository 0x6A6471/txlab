open Melange_bitcoin_lib

let is_op_code value = Js.typeof value == "string" && Js.String.startsWith ~prefix:"OP_" value

(* TODO: remove in favor of input_of_script_type & output_of_script_type *)
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
    | _ ->
      if List.nth parts 1 = "OP_CHECKSIG" || List.nth parts 1 = "OP_CHECKMULTISIG"
      then "p2pk"
      else "unknown"
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
         && (List.nth parts 4 = "OP_CHECKSIG" || List.nth parts 4 = "OP_CHECKMULTISIG")
         && List.nth parts 2 |> String.length = 40
      then "p2pkh"
      else "unknown"
  end
  | _ -> begin
    if List.length parts >= 4
       && (List.nth parts (List.length parts - 1) = "OP_CHECKSIG"
           || List.nth parts (List.length parts - 1) = "OP_CHECKMULTISIG")
    then "p2ms"
    else "unknown"
  end
;;

let is_script_start (script : Js.Typed_array.Uint8Array.t) char1 char2 =
  Js.Typed_array.Uint8Array.length script >= 2
  && Js.Typed_array.Uint8Array.unsafe_get script 0 = char1
  && Js.Typed_array.Uint8Array.unsafe_get script 1 = char2
;;

let input_of_script_type (input : Transaction.input) =
  try
    let script = input.script in
    let witness = input.witness in
    let script_len = Js.Typed_array.Uint8Array.length script in

    let witness_len = Array.length witness in

    (* 1. Native P2WSH (empty scriptSig, witness with script + sigs) *)
    if script_len = 0 && witness_len > 0
    then (
      (* Heuristically decide between P2WPKH or P2WSH *)
      let wit0 = Js.Typed_array.Uint8Array.unsafe_get witness.(0) 0 in
      if witness_len = 2 && wit0 = 0x48 then "P2WPKH" else "P2WSH" (* 2. P2PK *))
    else if script_len >= 70
            && script_len <= 75
            && (Js.Typed_array.Uint8Array.unsafe_get script 0 >= 0x47
                && Js.Typed_array.Uint8Array.unsafe_get script 0 <= 0x49)
            && Js.Typed_array.Uint8Array.unsafe_get script 1 = 0x30
            && Js.Typed_array.Uint8Array.unsafe_get script (script_len - 1) = 0x01
    then "P2PK" (* 3. P2SH-P2WSH *)
    else if script_len = 35
            && is_script_start script 0x22 0x00
            && Js.Typed_array.Uint8Array.unsafe_get script 2 = 0x20
    then "P2SH-P2WSH" (* 4. P2SH-P2WPKH *)
    else if script_len = 23
            && is_script_start script 0x16 0x00
            && Js.Typed_array.Uint8Array.unsafe_get script 2 = 0x14
    then "P2SH-P2WPKH" (* 5. Legacy P2SH *)
    else if script_len > 20
            && Js.Typed_array.Uint8Array.unsafe_get script 0 = 0xa9
            && Js.Typed_array.Uint8Array.unsafe_get script (script_len - 1) = 0x87
    then "P2SH" (* 6. Legacy P2PKH *)
    else if script_len > 100 && script_len < 200
    then "P2PKH"
    else "Unknown"
  with
  | _ -> "Unidentifiable"
;;
