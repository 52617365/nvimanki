-- Neovim global plugin that uploads notes into Anki.
-- Last Change:	2022 Jun 18
-- Maintainer:	Rasmus Mäki <https://github.com/52617365/>
-- License:	This file is placed in the public domain.
local ui = require('nvimanki.picker')
local api = require('nvimanki.api')
local utils = require('nvimanki.utils')

-- TODO:
-- UI to delete done when api starts working.
-- Keybinding to update decks.

-- public interface starts here.
local G = {}

-- format is |question| - |answer|
function G.create_deck_from_visualization()
  local visualized_text = utils.visual_selection()
  local dash = string.find(visualized_text, "|-|")
  if dash == nil then
    print("Incorrect form.")
  else
    local question = visualized_text.sub(0, dash)
    local answer = visualized_text.sub(dash + 1, #visualized_text)
    api.choose_deck(question, answer)
  end
end

function G.create_note()
  ui.make_a_note()
end

function G.create_deck()
  ui.make_a_deck()
end

function G.update_decks()
  api.update_decks()
end

function G.delete_deck()
  -- add deleting once api is not fucked.
end

return G
