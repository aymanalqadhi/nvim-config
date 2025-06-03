;; extends


(normal_command
  (identifier) @_name (#eq? @_name "check_source_compiles")
  (argument_list
    (argument
      (unquoted_argument) @injection.language)
    (argument
      (bracket_argument
        (bracket_argument_open)
        (bracket_argument_content) @injection.content
        (bracket_argument_close)))
    )
)
