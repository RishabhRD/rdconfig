local stl = require "rd.stl"

local autoformat_global_disabled = false
local autoformat_disabled_buffers = {}

local function autoformat_enable_global()
  autoformat_global_disabled = false
end

local function autoformat_disable_global()
  autoformat_global_disabled = true
end

local function is_autoformat_disabled_globally()
  return autoformat_global_disabled
end

local function autoformat_enable(buf)
  autoformat_disabled_buffers[buf] = nil
end

local function autoformat_disable(buf)
  autoformat_disabled_buffers[buf] = true
end

local function can_autoformat_with_buf(buf)
  return autoformat_disabled_buffers[buf] == nil
end

local function fname_compare(noformat_file, fname)
  -- netrw sometimes opens project files with absolute path
  return (fname == noformat_file) or (fname == stl.to_absolute(noformat_file))
end

local function can_autoformat_with_file(fname)
  return stl.contains_in_array(stl.lines_from ".noformat", fname, fname_compare) == false
end

local function can_autoformat(buf, fname)
  return can_autoformat_with_buf(buf) and can_autoformat_with_file(fname)
end

return {
  autoformat_enable_global = autoformat_enable_global,
  autoformat_disable_global = autoformat_disable_global,
  is_autoformat_disabled_globally = is_autoformat_disabled_globally,
  autoformat_enable = autoformat_enable,
  autoformat_disable = autoformat_disable,
  can_autoformat = can_autoformat,
}
