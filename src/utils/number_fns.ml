let btc_of_sats sats =
  try
    let sats_str = Js.Bigint.toString sats in
    let cleaned_str = String.concat "" (String.split_on_char ',' sats_str) in
    let sats_float = float_of_string cleaned_str in

    sats_float /. 100_000_000. |> Js.Float.toString
  with
  | exn ->
    let error_message = Printexc.to_string exn in
    Js.Console.error ("Error formatting BTC: " ^ error_message);
    "error"
;;
