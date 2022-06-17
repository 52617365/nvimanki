-- Neovim global plugin that uploads notes into Anki.
-- Last Change:	2022 Jun 13
-- Maintainer:	Rasmus Mäki <rasengithub@protonmail.com>
-- License:	This file is placed in the public domain.
local ui = require('nvimanki.picker')
local api = require('nvimanki.api')

local G = {}

function G.testimodule()
  -- local asd = ui.display_decks()
  -- local question = ui.choose_question()
  -- api.create_deck()
  -- local decks = api.update_decks()
  -- ui.gen_menu_items()
  local answer = ui.choose_answer()
  -- for index, value in ipairs(items) do
  --   print(vim.inspect(value.text))
  -- end
  -- ui.choose_question()
  -- api.delete_deck()
end

return G
