local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local fileio = require 'nvimanki.fileio'
local Input = require("nui.input")
local api = require "nvimanki.api"
local G = {}

G.gen_menu_items = function()
  local decks = fileio.read_deck_file()
  local items = {}
  for index, value in ipairs(decks) do
    items[#items + 1] = Menu.item(value)
  end
  return items
end

-- TODO: Capture the result of this function.
G.choose_deck = function(question, answer)
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
        top = "Choose Deck",
        top_align = "center",
      },
    },
    win_options = {
      winblend = 10,
      winhighlight = "Normal:Normal",
    },
  }, {
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
    on_submit = function(deck)
      api.create_note(deck.text, question, answer)
    end,
  })
  -- mount the component
  menu:mount()
  -- close menu when cursor leaves buffer
  menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end

G.make_a_deck = function()
  local input = Input({
    position = "20%",
    size = {
      width = 20,
      height = 2,
    },
    relative = "editor",
    border = {
      style = "single",
      text = {
        top = "Deck name:",
        top_align = "center",
      },
    },
    win_options = {
      winblend = 10,
      winhighlight = "Normal:Normal",
    },
  }, {
    prompt = "> ",
    default_value = "",
    on_close = function()
      print("Input closed!")
    end,
    on_submit = function(value)
      api.create_deck(value)
    end,
  })
  -- mount/open the component
  input:mount()
  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

G.make_a_note = function()
  local input = Input({
    position = "20%",
    size = {
      width = 20,
      height = 2,
    },
    relative = "editor",
    border = {
      style = "single",
      text = {
        top = "Enter question:",
        top_align = "center",
      },
    },
    win_options = {
      winblend = 10,
      winhighlight = "Normal:Normal",
    },
  }, {
    prompt = "> ",
    default_value = "",
    on_close = function()
      print("Input closed!")
    end,
    on_submit = function(value)
      G.make_answer_card(value)
    end,
  })
  -- mount/open the component
  input:mount()
  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

G.make_answer_card = function(question)
  local input = Input({
    position = "20%",
    size = {
      width = 20,
      height = 2,
    },
    relative = "editor",
    border = {
      style = "single",
      text = {
        top = "Enter answer:",
        top_align = "center",
      },
    },
    win_options = {
      winblend = 10,
      winhighlight = "Normal:Normal",
    },
  }, {
    prompt = "> ",
    default_value = "",
    on_close = function()
      print("Input closed!")
    end,
    -- TODO: Collect this value.
    on_submit = function(answer)
      -- send request or ask for deck.
      G.choose_deck(question, answer)
    end,
  })
  -- mount/open the component
  input:mount()
  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return G
