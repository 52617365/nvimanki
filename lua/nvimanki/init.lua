-- Neovim global plugin that uploads notes into Anki.
-- Last Change:	2022 Jun 13
-- Maintainer:	Rasmus Mäki <rasengithub@protonmail.com>
-- License:	This file is placed in the public domain.
local utils = require('nvimanki.utils')

local G = {}

function G.testimodule()
  local decks_json = utils.get_all_decks()
  local decks_parsed = vim.fn.json_decode(decks_json)

  print(vim.inspect(decks_parsed.result))
end

return G
