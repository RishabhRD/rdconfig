local nnoremap = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end

local vnoremap = function(lhs, rhs, opts)
  vim.keymap.set("v", lhs, rhs, opts)
end

local inoremap = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts)
end

local map = function(type, key, value)
  P(value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true })
end

local buf_inoremap = function(lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = 0
  inoremap(lhs, rhs, opts)
end

local buf_nnoremap = function(lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = 0
  nnoremap(lhs, rhs, opts)
end

local buf_vnoremap = function(lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = 0
  vnoremap(lhs, rhs, opts)
end

return {
  nnoremap = nnoremap,
  vnoremap = vnoremap,
  buf_inoremap = buf_inoremap,
  buf_nnoremap = buf_nnoremap,
  buf_vnoremap = buf_vnoremap,
  map = map,
}
