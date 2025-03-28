let is_op_code value =
  Js.typeof value == "string" && Js.String.startsWith ~prefix:"OP_" value
;;
