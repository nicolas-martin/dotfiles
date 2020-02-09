## coc
```:CocConfig```
```
{
  "languageserver": {
    "golang": {
      "command": "gopls",
      "rootPatterns": ["go.mod", ".vim/", ".git/", ".hg/"],
      "filetypes": ["go"]
    }
  }
}
```

[more about languageserver](https://github.com/neoclide/coc.nvim/wiki/Language-servers)
