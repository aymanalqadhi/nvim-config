local M = {}

-- plugin uri
M.uri = 'kevinhwang91/nvim-ufo'

-- plugin dependencies
M.dependencies = { 'kevinhwang91/promise-async' }

-- plugin configuration function
function M.configure()
  local ufo = require('ufo')

  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d ... '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0

    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end

    table.insert(newVirtText, { suffix, 'MoreMsg' })

    return newVirtText
  end

  ufo.setup {
    open_fold_hl_timeout = 150,
    close_fold_kinds = { 'imports', 'comment' },
    fold_virt_text_handler = handler,
    provider_selector = function()
      return { 'treesitter', 'indent' }
    end
  }

  ufo.setFoldVirtTextHandler(vim.api.nvim_get_current_buf(), handler)
end

-- pluginin keymaps
function M.set_keymaps(k)
  local ufo = require('ufo')

  -- normal mode keys
  k.register({
    z = {
      name = 'ufo',
      R = { ufo.openAllFolds, 'Open All Folds' },
      M = { ufo.closeAllFolds, 'Close All Folds' },
      r = { ufo.openFoldsExceptKinds, 'Open Folds Except' },
      m = { ufo.closeFoldsWith, 'Close Folds With' },
    },
    K = {
      function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      'Hover'
    }
  })
end

return M
