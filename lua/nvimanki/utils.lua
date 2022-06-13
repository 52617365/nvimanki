local Job = require 'plenary.job'
local curl = require "plenary.curl"

local G = {}

-- Returns the text contents of the visualized text.
G.visual_selection = function()
  -- does not handle rectangular selection
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  if lines[1] ~= nil then
    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
      lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
      lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    return lines
  else
    return ""
  end
end

-- G.get_all_decks = function()
--   local command = [[curl localhost:8765 -X POST -d '{"action": "deckNames", "version": 7}']]
--   Job:new({
--     command = command,
--     args = {},
--     cwd = '/usr/bin',
--     env = { ['a'] = 'b' },
--     on_exit = function(j, return_val)
--       print(return_val)
--       print(j:result())
--     end,
--   }):sync() -- or start()
-- end

G.get_all_decks = function()
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
