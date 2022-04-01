local autoformat_enabled = true

local function autoformat_enable()
  autoformat_enabled = true
end

local function autoformat_disable()
  autoformat_enabled = false
end

local function is_autoformat_enabled()
  return autoformat_enabled
end

return {
  autoformat_enable = autoformat_enable,
  autoformat_disable = autoformat_disable,
  is_autoformat_enabled = is_autoformat_enabled,
}
