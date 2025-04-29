let hex_of_buffer (buffer : Js.uint8Array) : string =
  let len = Js.Typed_array.Uint8Array.length buffer in
  let hex_chars = Array.make (len * 2) '0' in
  (* Convert to hex in order *)
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

  (* Convert to hex in reverse order *)
  for i = 0 to len - 1 do
    let byte = Js.Typed_array.Uint8Array.unsafe_get buffer (len - 1 - i) in
    let hex = Printf.sprintf "%02x" byte in
    hex_chars.(i * 2) <- hex.[0];
    hex_chars.((i * 2) + 1) <- hex.[1]
  done;

  String.init (len * 2) (fun i -> hex_chars.(i))
;;
