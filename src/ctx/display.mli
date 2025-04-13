open React
open Melange_bitcoin_lib

type context_value =
  { network : Networks.t
  ; toggle_network : unit -> unit
  ; unit : string
  ; set_unit : string -> unit
  }

val init : context_value

val display_context : context_value React.Context.t

module Provider : sig
  include module type of Context

  val make : < children : element ; value : context_value > Js.t component
end

module DisplayProvider : sig
  val make : children:React.element -> unit -> React.element [@@react.component]
end
