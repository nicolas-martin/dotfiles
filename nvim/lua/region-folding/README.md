# region-folding.nvim

A Neovim plugin that enables custom code folding using region markers in comments across multiple programming languages.

## Features

- Automatic code folding based on region markers in comments
- Support for 20+ programming languages out of the box
- Smart detection of language-specific comment syntax
- Minimal configuration required
- Works out of the box with common region markers

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "nma/region-folding.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
```

## Usage

The plugin works automatically after installation. It automatically detects the appropriate comment syntax for each language and supports region markers in the following format:

```
<comment_char>[space][#][space]region
<comment_char>[space][#][space]endregion
```

For example:
- JavaScript/TypeScript: `// region` or `// #region`
- Python/Ruby/Shell: `# region` or `# #region`
- Lua: `-- region` or `-- #region`
- C/C++/Rust/Go: `// region` or `// #region`
- Vim: `" region` or `" #region`

### Supported Languages

Out of the box support for:
- JavaScript/TypeScript
- Python
- Lua
- C/C++
- Rust
- Go
- Java
- PHP
- Ruby
- Perl
- Shell scripts (sh, bash, zsh, fish)
- YAML
- TOML
- Vim
- And more...

Example usage:

```javascript
// region Database Configuration
const dbConfig = {
  host: 'localhost',
  port: 5432,
  // ... more configuration
};
// endregion

// region API Routes
const router = express.Router();
// ... route definitions
// endregion
```

## Configuration

You can customize the region marker text and spacing:

```lua
require('region-folding').setup({
  -- Customize the region marker text
  region_text = {
    start = "region",    -- Default: "region"
    ending = "endregion" -- Default: "endregion"
  },
  -- Control spacing between comment and region text
  space_after_comment = true -- Default: true
})
```

## Commands

The plugin uses Neovim's built-in fold commands:

- `zo` - Open fold under cursor
- `zc` - Close fold under cursor
- `za` - Toggle fold under cursor
- `zR` - Open all folds
- `zM` - Close all folds

## License

MIT 