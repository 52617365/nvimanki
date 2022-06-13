-- Neovim global plugin that uploads notes into Anki.
-- Last Change:	2022 Jun 13
-- Maintainer:	Rasmus Mäki <rasengithub@protonmail.com>
-- License:	This file is placed in the public domain.
local utils = require('nvimanki.utils')

local G = {}

function G.testimodule()
  local decks = vim.fn.json_decode(utils.get_all_decks())

  if decks.error ~= vim.NIL then
    print("server not running")
  else
    print(vim.inspect(decks.result))
  end
end

return G
