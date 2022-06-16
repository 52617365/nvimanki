local G = {}

G.write_to_file = function(contents)
  -- local path = vim.api.nvim_list_runtime_paths() .. "/.nvimanki/decks.txt"
  -- print(path)
  local testing_path = "testfile.txt"
  local file = io.open(testing_path, "w")
  if file ~= nil then
    for i, v in pairs(contents) do
      file:write(v, "\n")
    end
    print("Successfully updated decks.")
  else
    print("Error opening config file.")
  end
end

return G
