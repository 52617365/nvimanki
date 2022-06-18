-- Neovim global plugin that uploads notes into Anki.
-- Last Change:	2022 Jun 13
-- Maintainer:	Rasmus Mäki <rasengithub@protonmail.com>
-- License:	This file is placed in the public domain.
local ui = require('nvimanki.picker')
local api = require('nvimanki.api')

local G = {}

function G.testimodule()
  -- ui.make_question_card()
  -- api.update_decks()
  -- api.create_deck("somedecknamexd")
  -- api.create_note("somedecknamexd", "question", "answer")
  ui.make_a_note()
  -- api.delete_deck("somedecknamexd")
end

return G
