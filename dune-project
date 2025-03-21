(lang dune 3.18)

(name cipher)

(generate_opam_files true)

(source
 (github 0x6a6471/cipher))

(authors "0x6a6471")

(maintainers "0x6a6471")

(using melange 0.1)

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
 (name cipher)
 (synopsis "A short synopsis")
 (allow_empty)
 (description "A longer description")
 (depends
   ocaml dune melange reason-react
   ;; mlx
   mlx ocamlmerlin-mlx
   ;; dev tools
   ocamlformat-mlx ocamlformat ocamlformat-rpc ocaml-lsp-server)
 (tags (bitcoin)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
