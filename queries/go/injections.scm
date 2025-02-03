((comment) @_header (#match? @_header "^//\\s*sql")
 (const_declaration
  (const_spec
   name: (identifier) @_name
   value: (expression_list [(raw_string_literal)
                            (interpreted_string_literal)] @injection.content
                            (#offset! @injection.content 0 1 0 -1)
                            (#set! injection.language "sql")))))

(call_expression
  function: (selector_expression
    field: (field_identifier) @_function (#any-of? @_function "Query" "QueryRow" "Exec" "ExecOne" "One" "All"))
  arguments: (argument_list [(raw_string_literal)
                             (interpreted_string_literal)] @injection.content
               (#offset! @injection.content 0 1 0 -1)
               (#set! injection.language "sql")))

(call_expression
  function: (identifier) @_function (#any-of? @_function "Query" "QueryRow" "Exec" "ExecOne" "One" "All")
  arguments: (argument_list [(raw_string_literal)
                             (interpreted_string_literal)] @injection.content
               (#offset! @injection.content 0 1 0 -1)
               (#set! injection.language "sql")))
