let get_item : string -> string option =
  [%mel.raw
    {|
  function(key) {
    const value = localStorage.getItem(key);
    return value === null ? undefined : value;
  }
|}]
;;

let set_item : string -> string -> unit =
  [%mel.raw {|
  function(key, value) {
    localStorage.setItem(key, value);
  }
|}]
;;

let remove_item : string -> unit =
  [%mel.raw {|
  function(key) {
    localStorage.removeItem(key);
  }
|}]
;;

let clear : unit -> unit = [%mel.raw {|
  function() {
    localStorage.clear();
  }
|}]

let set_json : string -> 'a -> unit =
  [%mel.raw
    {|
  function(key, value) {
    try {
      const jsonString = JSON.stringify(value);
      localStorage.setItem(key, jsonString);
    } catch(e) {
      console.error("Failed to stringify value:", e);
    }
  }
|}]
;;

let get_json : string -> 'a option =
  [%mel.raw
    {|
  function(key) {
    try {
      const jsonString = localStorage.getItem(key);
      if (jsonString === null) return undefined;
      return JSON.parse(jsonString);
    } catch(e) {
      console.error("Failed to parse JSON from localStorage:", e);
      return undefined;
    }
  }
|}]
;;
