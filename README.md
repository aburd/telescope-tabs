## Description

A [telescope](https://github.com/nvim-telescope/telescope.nvim) plugin for viewing your tabs and jumping to them. This plugin is written in fennel using the wonderful [nfnl](https://github.com/Olical/nfnl) made by Olical.

![telescope-tabs](https://github.com/aburd/telescope-tabs/assets/6701630/830e59cf-264c-483f-a71f-6df80161b1d7)

## Installation

You will need to have [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) installed.

Then install the plugin with any plugin manager. For example with lazy:

```
require("lazy").setup {
  "aburd/telescope-tabs" 
}
```

Then register the extension somewhere:
```lua
require('telescope').load_extension('tabs')
```

## Usage

Use in vim with `:Telescope tabs`.

Or setup a key binding:

```vim
nnoremap <C-j> :Telescope tabs<CR>
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
