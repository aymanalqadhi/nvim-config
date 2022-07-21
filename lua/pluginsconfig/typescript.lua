local typescript = require('typescript')

local function configure()
    typescript.setup {
        debug = false,
    }
end

return {
    configure = configure
}
