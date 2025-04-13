open Melange_bitcoin_lib

type t = Psbt.psbt_tx_output

val make
  :  outputs:t array
  -> display_unit:string
  -> set_display_unit:(string -> unit)
  -> React.element
[@@react.component]
