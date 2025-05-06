open Melange_bitcoin_lib

val hex_of_buffer : Js.uint8Array -> string
val hex_of_buffer_rev : Js.uint8Array -> string
val decode_script : Transaction.input -> string
