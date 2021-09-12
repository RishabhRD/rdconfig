local M = {}

return setmetatable({}, {
  __index = function(_, k)
    local has_custom, custom = pcall(require, string.format("rd.telescope.custom.%s", k))

    if M[k] then
      return M[k]
    elseif has_custom then
      return custom
    else
      return require("telescope.builtin")[k]
    end
  end,
})
