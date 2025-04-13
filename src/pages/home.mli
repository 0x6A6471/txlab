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
  | Set_hex of string
  | Set_psbt of 'a psbt
  | Toggle_network of bool
  | Select_display_unit of string
  | Set_error of string option

type 'a state =
  { hex : string
  ; psbt : 'a psbt
  ; is_mainnet : bool
  ; display_unit : string
  ; error : string option
  }

val reducer : 'a state -> 'a action -> 'a state

val make : unit -> React.element [@@react.component]
