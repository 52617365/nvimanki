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
G.send_request = function(query)
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
    return res.body
  else
    print("Server not running.")
    return nil
  end
end

return G
