require('settings')
require('keymaps')
require('plugins')
require('lsp')
require('autocmds')
require('telescope_config')
require('cmp_config')
require('treesitter')
require('avante_config')

-- test force load plugins?
require('render-markdown').setup()
require('img-clip').setup()
require("typescript-tools").setup {}

require('rust-tools').setup()
require('neodev').setup()
require('dressing').setup()

