let txid_of_uint8Array (hash : Js.uint8Array) : string =
  let len = Js.Typed_array.Uint8Array.length hash in
  let hex_chars = Array.make (len * 2) '0' in

  (* Reverse and convert to hex in one pass *)
  for i = 0 to len - 1 do
    let byte = Js.Typed_array.Uint8Array.unsafe_get hash (len - 1 - i) in
    let hex = Printf.sprintf "%02x" byte in
    hex_chars.(i * 2) <- hex.[0];
    hex_chars.((i * 2) + 1) <- hex.[1]
  done;

  String.init (len * 2) (fun i -> hex_chars.(i))
;;
