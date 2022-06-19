# nvimanki
## nvimanki utilizes the Anki-Connect API to bring Anki straight into Neovim.
## Requires plenary.nvim, nui.nvim and the AnkiConnect Anki plugin.
- Anki has to be opened for the AnkiConnect API to be usable.
### It lets you:
* Add new decks into Anki
* Create new notes (supports only basic as of now, more to come)
* Auto updates decks after creating

### Install:
```
Using Packer:
use { '52617365/nvimanki', requires = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"}}
```


### Default keybindings:
```
vim.keymap.set('n', '<leader>an', "<cmd>lua require('nvimanki').create_note()<cr>", opts)
vim.keymap.set('n', '<leader>ad', "<cmd>lua require('nvimanki').create_deck()<cr>", opts)
vim.keymap.set('n', '<leader>au', "<cmd>lua require('nvimanki').update_decks()<cr>", opts)
```


### TODO
- Auto insert a note from visualized text
- Add more note modes
- View notes
- Delete notes once Anki-Connect API start working https://github.com/FooSoft/anki-connect/issues/335
- ?
