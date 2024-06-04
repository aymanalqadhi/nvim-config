((comment) @_header (#eq? @_header "# METADATA")
 (comment) @injection.content

  (#offset! @injection.content 0 2 0 0)
  (#set! injection.language "yaml"))
