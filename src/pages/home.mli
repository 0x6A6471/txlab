open Melange_bitcoin_lib

type input = Psbt.psbt_tx_input
type ouput = Psbt.psbt_tx_output
type 'a global_psbt = 'a Bip174.t

type 'a psbt =
  { global_psbt : 'a global_psbt option
  ; inputs : input array
  ; outputs : ouput array
  }

type 'a action =
  | Set_user_input of string
  | Set_psbt of 'a psbt
  | Set_error of string option

type 'a state =
  { user_input : string
  ; psbt : 'a psbt
  ; error : string option
  }

val reducer : 'a state -> 'a action -> 'a state

val make : unit -> React.element [@@react.component]
