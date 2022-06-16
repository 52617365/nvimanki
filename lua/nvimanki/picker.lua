local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local fileio = require 'nvimanki.fileio'
local G = {}

G.gen_menu_items = function()
  local decks = fileio.read_deck_file()
  local items = {}
  for index, value in ipairs(decks) do
    items[#items + 1] = Menu.item(value)
  end
  return items
end

G.display_decks = function()
  local decks = G.gen_menu_items()
  local menu = Menu({
    position = "20%",
    size = {
      width = 20,
      height = #decks + 1,
    },
    relative = "editor",
    border = {
      style = "single",
      text = {
        top = "Choose Something",
        top_align = "center",
      },
    },
    win_options = {
      winblend = 10,
      winhighlight = "Normal:Normal",
    },
  },
    {
      lines = decks,
      max_width = 20,
      keymap = {
        focus_next = { "j", "<Down>", "<Tab>" },
        focus_prev = { "k", "<Up>", "<S-Tab>" },
        close = { "<Esc>", "<C-c>" },
        submit = { "<CR>", "<Space>" },
      },
      on_close = function()
        print("CLOSED")
      end,
      on_submit = function(item)
        print("SUBMITTED", vim.inspect(item))
      end,
    })

  -- mount the component
  menu:mount()

  -- close menu when cursor leaves buffer
  menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end

return G
