local curl = require "plenary.curl"
local M = require 'nvimanki.fileio'
local G = {}

-- TODO:
-- Update the file containing decks everytime a new deck gets created or a deck gets deleted.
-- Prompt user to update decks if they can't be found.

G.api_error_handling = function(res, success, error)
  if res.status == 200 then
    local parsed_response = vim.fn.json_decode(res.body)
    if parsed_response.error ~= vim.NIL then
      print(error)
      return 1
    else
      print(success)
      return 0
    end
  else
    print(error)
    return 1
  end
end

G.send_post_request = function(body, success, error)
  local res = curl.post("127.0.0.1:8765", {
    body = vim.fn.json_encode(body),
    headers = {
      content_type = "application/json",
    },
  })

  -- Return nil if error.
  local err = G.api_error_handling(res, success, error)
  if err == 1 then
    return err
  else
    return res
  end

end

-- Gets all decks from the AnkiConnect endpoint and then writes them all into a file.
G.update_decks = function()
  local body = {
    action = "deckNames",
    version = 7,
  }
  local res = G.send_post_request(body, "succesfully updated decks", "error updating decks")

  -- if it was not an error, write to file.
  if res ~= 1 then
    M.write_to_file(res.result)
  end
end

G.create_note = function(deck, question, answer)
  local body = {
    action = "addNote",
    version = 6,
    params = {
      note = {
        deckName = deck,
        modelName = "Basic",
        fields = {
          Front = question,
          Back = answer
        },
        options = {
          allowDuplicate = false,
          duplicateScope = "deck",
          duplicateScopeOptions = {
            deckName = deck,
            checkChildren = false,
            checkAllModels = false
          }
        },
      }
    }
  }
  local _ = G.send_post_request(body, "succesfully created note", "error creating note")
end


-- TODO: Get deck_name from user.
G.create_deck = function(deck_name)
  local body = {
    action = "createDeck",
    version = 7,
    params = { deck = deck_name },
  }

  local res = G.send_post_request(body, "succesfully created " .. deck_name, "error creating " .. deck_name)

  if res == 0 then
    G.update_decks()
  end
end

-- TODO: MAKE THIS WORK.
-- SEEMS TO BE SOMETHING WRONG WITH THE API ITSELF.
G.delete_deck = function()
  local deck_name = "asd"
  local body = {
    action = "deleteDecks",
    version = 6,
    params = {
      decks = { deck_name },
      cardsToo = true
    }
  }
  print(vim.fn.json_encode(body))

  local res = G.send_post_request(body, "succesfully deleted " .. deck_name, "error deleting " .. deck_name)

  -- if success, update decks.
  if res == 0 then
    G.update_decks()
  end
end

return G
