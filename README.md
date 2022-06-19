# nvimanki
## nvimanki utilizes the Anki-Connect API to bring Anki straight into Neovim.
## Requires plenary.nvim, nui.nvim and the AnkiConnect Anki plugin.
- Anki has to be opened for the AnkiConnect API to be usable.

### IMPORTANT
- When you use the plugin for the first time, make sure to call update_decks() to make nvimanki aware of the decks you have. In the future, you only have to do this if you update Anki outside of Neovim.


### It lets you:
* Add new decks into Anki
* Create new notes (supports only basic as of now, more to come)
* Auto updates decks after creating
* Auto import basic question + answer pairs from line (question|answer) is format.



### Install:
```
Using Packer:
use { '52617365/nvimanki', requires = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"}}
```


### Example keybindings:
```
vim.keymap.set('n', '<leader>an', "<cmd>lua require('nvimanki').create_note()<cr>", opts)
vim.keymap.set('n', '<leader>ad', "<cmd>lua require('nvimanki').create_deck()<cr>", opts)
vim.keymap.set('n', '<leader>au', "<cmd>lua require('nvimanki').update_decks()<cr>", opts)
vim.keymap.set('x', '<leader>av', "<cmd>lua require('nvimanki').create_deck_from_visualization()<cr>", opts)
```
> Example format for create_deck_from_visualization()
`question|answer`


### TODO
- Add more note modes
- View notes
- Delete notes once Anki-Connect API start working https://github.com/FooSoft/anki-connect/issues/335
- ?
