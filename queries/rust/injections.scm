; extends

;; sqlx `query*` macros
(macro_invocation
  ;; query macro
  (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#match? @_name "^query"))

  ;; query string
  (token_tree (raw_string_literal) @injection.content)

  (#offset! @injection.content 1 0 0 0)
  (#set! injection.language "sql"))

;; `(sqlx|diesel)::(.*query.*)` functions with raw string literals
(call_expression
  ;; query function
  (scoped_identifier
    path: (identifier) @_path (#any-of? @_path "sqlx" "diesel")
    name: (identifier) @_name (#contains? @_name "query"))

  ;; query string
  (arguments (raw_string_literal) @injection.content)

  (#offset! @injection.content 1 0 0 0)
  (#set! injection.language "sql"))

;; `(sqlx|diesel)::(.*query.*)` functions with string literals
(call_expression
  ;; query function
  (scoped_identifier
    path: (identifier) @_path (#any-of? @_path "sqlx" "diesel")
    name: (identifier) @_name (#contains? @_name "query"))

  ;; query string
  (arguments (string_literal) @injection.content)

  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "sql"))

;; inline assembly
(macro_invocation
  macro: [
    (identifier) @_name
    (scoped_identifier name: (identifier) @_name)
  ] (#eq? @_name "asm")

  (token_tree
    (string_literal
      (string_content) @injection.content))

  (#set! injection.language "nasm"))
