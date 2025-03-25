val make
  :  name:string
  -> ?className:string
  -> ?variant:[ `filled | `line ]
  -> ?size:string
  -> React.element
[@@react.component]
