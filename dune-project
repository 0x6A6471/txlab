(lang dune 3.18)

(name txlab)

(generate_opam_files true)

(source
 (github 0x6a6471/txlab))

(authors "0x6a6471")

(maintainers "0x6a6471")

(using melange 0.1)

; bitcoin-lib
;; dev
; (pin
;  (url "../melange-bitcoin-lib")
;  (package (name melange-bitcoin-lib)))
;; production
(pin
 (url "git+https://github.com/0x6A6471/melange-bitcoin-lib")
 (package (name melange-bitcoin-lib)))

; radix-ui
;; dev
; (pin
;  (url "../melange-radix-ui")
;  (package (name melange-radix-ui)))
;; production
(pin
 (url "git+https://github.com/0x6A6471/melange-radix-ui")
 (package (name melange-radix-ui)))

; mlx files
(dialect
 (name mlx)
 (implementation
  (extension mlx)
  (merlin_reader mlx)
  (preprocess
   (run mlx-pp %{input-file}))))

; (license LICENSE)

(package
 (name txlab)
 (synopsis "A short synopsis")
 (allow_empty)
 (description "A longer description")
 (depends
   ocaml dune melange reason-react 
   ;; bindings
   melange-bitcoin-lib melange-radix-ui
   ;; mlx
   mlx ocamlmerlin-mlx
   ;; dev tools
   ocamlformat-mlx ocamlformat ocamlformat-rpc ocaml-lsp-server)
 (tags (bitcoin)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
