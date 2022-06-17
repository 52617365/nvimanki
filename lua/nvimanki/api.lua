local curl = require "plenary.curl"
local M = require "nvimanki.fileio"
local G = {}

-- TODO:
-- Update the file containing decks everytime a new deck gets created or a deck gets deleted.
-- Prompt user to update decks if they can't be found.

-- Gets all decks from the AnkiConnect endpoint and then writes them all into a file.
G.update_decks = function()
  local body = {
    action = "deckNames",
    version = 7,
  }

  local res = curl.post("127.0.0.1:8765", {
    body = vim.fn.json_encode(body),
    headers = {
      content_type = "application/json",
    },
  })

  if res.status == 200 then
    local parsed_response = vim.fn.json_decode(res.body)
    if parsed_response.error ~= vim.NIL then
      print("server not running")
      return nil
    else
      M.write_to_file(parsed_response.result)
      return 0
    end
  else
    print("error sending request")
    return nil
  end
end

-- This is not yet used.
G.create_card = function(question, answer, deck_name, card_name)

  G.update_decks()
end


-- TODO: Get deck_name from user.
G.create_deck = function(deck_name)
  local body = {
    action = "createDeck",
    version = 7,
    params = { deck = deck_name },
  }

  local res = curl.post("127.0.0.1:8765", {
    body = vim.fn.json_encode(body),
    headers = {
      content_type = "application/json",
    },
  })

  if res.status == 200 then
    local parsed_response = vim.fn.json_decode(res.body)
    if parsed_response.error ~= vim.NIL then
      print("Error creating deck, check that your server is running")
      return 1
    else
      print("Succesfully created " .. deck_name)
      return 0
    end
  else
    print("error sending request")
    return nil
  end
  G.update_decks()
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

  local res = curl.post("127.0.0.1:8765", {
    body = vim.fn.json_encode(body),
    headers = {
      content_type = "application/json",
    },
  })

  if res.status == 200 then
    local parsed_response = vim.fn.json_decode(res.body)
    if parsed_response.error ~= vim.NIL then
      print(res.body)
      -- print("Error deleting deck, check that your server is running")
      return 1
    else
      -- print("Succesfully deleted " .. deck_name)
      print(res.body)
      return 0
    end
  else
    print(res.body)
    -- print("Error deleting deck, check that your server is running")
    return 1
  end
  G.update_decks()
end

return G
