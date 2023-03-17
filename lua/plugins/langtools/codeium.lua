local M = {}

-- plugin uri
M.uri = 'Exafunction/codeium.vim'
--
-- -- plugin keymaps
-- function M.set_keymaps(k)
--   -- insert mode keys
--   k.register({
--     ['<C-g>'] = {
--       function() vim.fn['codeium#Accept']() end,
--       'Accept Codeium Suggestion'
--     },
--     ['<C-c>'] = {
--       function () vim.fn['codeium#Clear']() end,
--       'Clear Codeium Suggestion'
--     },
--     ['<C-;>'] = {
--       function() vim.fn['codeium#CycleCompletions'](1) end,
--       'Next Codeium Suggestion'
--     },
--     ['<C-,>'] = {
--       function() vim.fn['codeium#CycleCompletions'](-1) end,
--       'Previous Codeium Suggestion'
--     }
--   }, { mode = 'i' })
-- end

return M
