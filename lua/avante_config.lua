-- Avante configuration
require('avante').setup({
        provider = "copilot",
        claude = {
                api_key_name = "cmd:pass nico/anthropic", -- the shell command must be prefixed with `cmd:(.*)`
        }
})
