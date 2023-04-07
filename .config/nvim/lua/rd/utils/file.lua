local function read_file(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read "*all"
  f:close()
  return content
end

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then
    f:close()
  end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
local function lines_from(file)
  if not file_exists(file) then
    P "NO"
    return {}
  end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

return {
  read_file = read_file,
  file_exists = file_exists,
  lines_from = lines_from,
}
