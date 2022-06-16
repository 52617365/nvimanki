local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local fileio = require 'nvimanki.fileio'
local Input = require("nui.input")

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
G.choose_deck = function()
  local decks = G.gen_menu_items() or print("You don't have any decks, update your decks.")
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
        top = "Choose deck",
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
        print("Deck chooser closed")
      end,
      on_submit = function(item)
        print("SUBMITTED", vim.inspect(item))
        return item
      end,
    })
  -- mount the component
  menu:mount()
  -- close menu when cursor leaves buffer
  menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end

G.deck_creation = function(text)
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
        top = text,
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
    on_submit = function(value)
      print(value)
    end,
  })
  -- mount/open the component
  input:mount()
  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

-- TODO: Capture the result of this function.
G.choose_question = function()
  local question = G.deck_creation("Enter question:")
  if question ~= nil then
    return question
  else
    return question
  end
end

-- TODO: Capture the result of this function.
G.choose_answer = function()
  local answer = G.deck_creation("Enter Answer:")
  if answer ~= "" then
    print(answer)
  else
    print("no answer provided.")
  end
end

return G
