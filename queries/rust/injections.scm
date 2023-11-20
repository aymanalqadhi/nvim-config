;; sqlx `query*` macros
(macro_invocation
  ;; query macro
  (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#match? @_name "^query"))

  ;; query string
  (token_tree [(string_literal)     @injection.content
               (raw_string_literal) @injection.content])

  (#offset! @injection.content 1 0 0 0)
  (#set! injection.language "sql"))
