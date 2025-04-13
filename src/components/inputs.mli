open Melange_bitcoin_lib

type input = Psbt.psbt_tx_input
type 'a global_psbt = 'a Bip174.t

val make : global_psbt:'a global_psbt option -> inputs:input array -> React.element
[@@react.component]
