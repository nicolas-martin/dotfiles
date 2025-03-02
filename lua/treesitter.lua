-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "lua", 
    "vim", 
    "typescript", 
    "javascript", 
    "go", 
    "rust", 
    "python", 
    "json", 
    "html", 
    "css", 
    "markdown"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  fold = {
    enable = true,
  },
} 