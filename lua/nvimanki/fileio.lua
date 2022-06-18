local G = {}

-- this should be called everything user updates or deletes decks.
G.write_to_file = function(contents)
  local path = vim.api.nvim_list_runtime_paths()[1] .. "/.nvimanki.txt"

  local file = io.open(path, "w")

  -- in other words, if file exists.
  if file ~= nil then
    for index, value in pairs(contents) do
      file:write(value, "\n")
    end
    file:close()
    print("Updated decks")
  else
    print("Error opening: " .. path)
  end
end


-- see if the file exists
local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- Reads file, returns an empty table if file does not exist.
G.read_deck_file = function()
  local file = "testfile.txt"
  if not file_exists(file) then
    return {}
  end
  local lines = {}
  -- io.lines closes file by default.
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

return G
