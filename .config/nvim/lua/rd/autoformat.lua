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

local function can_autoformat_buffer(buf)
  return autoformat_disabled_buffers[buf] == nil
end

return {
  autoformat_enable_global = autoformat_enable_global,
  autoformat_disable_global = autoformat_disable_global,
  is_autoformat_disabled_globally = is_autoformat_disabled_globally,
  autoformat_enable = autoformat_enable,
  autoformat_disable = autoformat_disable,
  can_autoformat_buffer = can_autoformat_buffer,
}
