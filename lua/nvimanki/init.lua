-- Neovim global plugin that uploads notes into Anki.
-- Last Change:	2022 Jun 13
-- Maintainer:	Rasmus Mäki <rasengithub@protonmail.com>
-- License:	This file is placed in the public domain.
local ui = require('nvimanki.picker')

local G = {}

function G.testimodule()
  -- local asd = ui.display_decks()
  -- local question = ui.choose_question()
  local deck = ui.choose_deck()
end

return G
