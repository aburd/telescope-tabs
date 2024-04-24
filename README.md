## Description

A [telescope](https://github.com/nvim-telescope/telescope.nvim) plugin for viewing your tabs and jumping to them.

## Installation

Install with any plugin manager. For example with lazy:

```
require("lazy").setup {
  "aburd/telescope-tabs" 
}
```

## Config

```lua
local telescope = require("telescope")
local themes = require("telescope.themes")

telescope.setup {
  extensions = {
    tabs = {
      theme = themes.get_ivy()
    }
  },
}
```

- `theme` - Any theme you would like the window to open up in. You can read more about [themes](https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#themes) on the telescope readme.
