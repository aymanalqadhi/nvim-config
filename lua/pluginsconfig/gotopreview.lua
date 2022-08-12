local goto_prev = require('goto-preview')

local function configure()
  goto_prev.setup {
    width = 120;
    height = 15;
    border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" };
    default_mappings = true;
    debug = false;
    opacity = nil;
    resizing_mappings = true;
    post_open_hook = nil;
    focus_on_open = true;
    dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
    force_close = true,
    bufhidden = "wipe",
  }
end

return {
  configure = configure
}
