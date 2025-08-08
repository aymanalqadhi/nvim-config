; extends

; check_source_compiles (language set via first argument)
(normal_command
  (identifier) @_name (#eq? @_name "check_source_compiles")
  (argument_list
    (argument
      (unquoted_argument) @injection.language)
    (argument
      (bracket_argument
        (bracket_argument_open)
        (bracket_argument_content) @injection.content
        (bracket_argument_close)))))

; check_c_source_compiles
(normal_command
  (identifier) @_name (#eq? @_name "check_c_source_compiles")
  (argument_list
    (argument
      (bracket_argument
        (bracket_argument_open)
        (bracket_argument_content) @injection.content
        (bracket_argument_close))))
  (#set! injection.language "c"))

; check_cxx_source_compiles
(normal_command
  (identifier) @_name (#eq? @_name "check_cxx_source_compiles")
  (argument_list
    (argument
      (bracket_argument
        (bracket_argument_open)
        (bracket_argument_content) @injection.content
        (bracket_argument_close))))
  (#set! injection.language "cpp"))
