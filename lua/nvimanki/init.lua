-- Neovim global plugin that uploads notes into Anki.
-- Last Change:	2022 Jun 13
-- Maintainer:	Rasmus Mäki <rasengithub@protonmail.com>
-- License:	This file is placed in the public domain.
local utils = require('nvimanki.api')

local G = {}

function G.testimodule()
  local decks = utils.get_all_decks()
  -- print(vim.inspect(decks))
end

return G
