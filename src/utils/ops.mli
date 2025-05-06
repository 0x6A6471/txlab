open Melange_bitcoin_lib

val is_op_code : string -> bool
val get_script_type_from_asm : string -> string
val input_of_script_type : Transaction.input -> string
