local Job = require 'plenary.job'

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

G.get_all_decks = function()
  local command = [[curl localhost:8765 -X POST -d '{"action": "deckNames", "version": 7}']]
  Job:new({
    command = command,
    args = {},
    cwd = '/usr/bin',
    env = { ['a'] = 'b' },
    on_exit = function(j, return_val)
      print(return_val)
      print(j:result())
    end,
  }):sync() -- or start()
end

G.send_request = function(query)
  local curl_opts = "curl -X POST -H \"Content-Type: application/json"
  local curl_payload = query .. ""

  local full_command = curl_opts .. curl_payload
  Job:new({
    command = 'rg',
    args = { '--files' },
    cwd = '/usr/bin',
    env = { ['a'] = 'b' },
    on_exit = function(j, return_val)
      print(return_val)
      print(j:result())
    end,
  }):sync() -- or start()
end

return G
