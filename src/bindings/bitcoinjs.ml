module Network = struct
  type bip32 =
    { public : int
    ; private_ : int
    }

  type t =
    { message_prefix : string
    ; bech32 : string
    ; bip32 : bip32
    ; pub_key_hash : int
    ; script_hash : int
    ; wif : int
    }
end

module Psbt = struct
  type t

  type psbt_opts =
    { network : Network.t option
    ; maximum_fee_rate : float option
    }

  let default_opts = { network = None; maximum_fee_rate = None }

  external fromHex : string -> ?psbt_opts:psbt_opts -> t = "fromHex"
  [@@mel.module "bitcoinjs-lib"] [@@mel.scope "Psbt"]
end
