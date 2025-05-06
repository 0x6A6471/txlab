open Melange_bitcoin_lib

let hex_of_buffer (buffer : Js.uint8Array) : string =
  let len = Js.Typed_array.Uint8Array.length buffer in
  let hex_chars = Array.make (len * 2) '0' in
  (* convert to hex in order *)
  for i = 0 to len - 1 do
    let byte = Js.Typed_array.Uint8Array.unsafe_get buffer i in
    let hex = Printf.sprintf "%02x" byte in
    hex_chars.(i * 2) <- hex.[0];
    hex_chars.((i * 2) + 1) <- hex.[1]
  done;
  String.init (len * 2) (fun i -> hex_chars.(i))
;;

let hex_of_buffer_rev (buffer : Js.uint8Array) : string =
  let len = Js.Typed_array.Uint8Array.length buffer in
  let hex_chars = Array.make (len * 2) '0' in

  (* convert to hex in reverse order *)
  for i = 0 to len - 1 do
    let byte = Js.Typed_array.Uint8Array.unsafe_get buffer (len - 1 - i) in
    let hex = Printf.sprintf "%02x" byte in
    hex_chars.(i * 2) <- hex.[0];
    hex_chars.((i * 2) + 1) <- hex.[1]
  done;

  String.init (len * 2) (fun i -> hex_chars.(i))
;;

let decode_script (input : Transaction.input) =
  (* check if this is a coinbase input *)
  let is_coinbase =
    let hash_len = Js.Typed_array.Uint8Array.length input.hash in
    let is_zero_hash = ref true in
    for i = 0 to hash_len - 1 do
      if Js.Typed_array.Uint8Array.unsafe_get input.hash i <> 0 then is_zero_hash := false
    done;
    !is_zero_hash && input.index = 4294967295
  in

  if is_coinbase
  then
    (* for coinbase, justconvert to raw hex without ASM interpretation *)
    hex_of_buffer input.script
  else (
    try
      (* for regular transactions, use the standard ASM decoder *)
      Script.toASM (Script.BufferChunks input.script)
    with
    | _ ->
      (* fallback to hex if script parsing fails *)
      hex_of_buffer input.script)
;;
