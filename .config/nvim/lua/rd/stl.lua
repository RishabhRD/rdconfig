local M = {}

M.split_with = function(str, sep)
  sep = sep or "%s"
  local t = {}
  for res in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(t, res)
  end
  return t
end

M.contains_in_array = function(tbl, ele)
  for _, val in ipairs(tbl) do
    if val == ele then
      return true
    end
  end
  return false
end

M.contains_in_table = function(tbl, ele)
  return tbl[ele] ~= nil
end

-- see if the file exists
M.file_exists = function(file)
  local f = io.open(file, "rb")
  if f then
    f:close()
  end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
M.lines_from = function(file)
  if not M.file_exists(file) then
    return {}
  end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

M.current_file_name = function()
  return vim.fn.expand "%"
end

return M
