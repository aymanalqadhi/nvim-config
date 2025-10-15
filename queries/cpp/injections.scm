; extends

(expression_statement
  (gnu_asm_expression
    assembly_code: (string_literal (string_content) @injection.content))

  (#set! injection.language "asm"))
