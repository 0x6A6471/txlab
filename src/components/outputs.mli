open Melange_bitcoin_lib

type t = Psbt.psbt_tx_output

val make : outputs:t array -> React.element [@@react.component]
