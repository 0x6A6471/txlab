(lang dune 3.18)

(name bitcoin-lib)

; (generate_opam_files true)

(source
 (github 0x6a6471/bitcoin-lib))

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
 (name bitcoin-lib)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
   ocaml dune melange reason-react
   ;; mlx
   mlx ocamlmerlin-mlx
   ;; dev tools
   ocamlformat ocaml-lsp-server)
 (tags (bitcoin)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
