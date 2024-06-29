P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

C = function(str)
  return pcall(require, str)
end

vim.fn.input = function(opts, other)
  local prompt = opts
  local default = other
  if other == nil then
    prompt = opts.prompt
    default = opts.default
  end

  return require("rd.utils.ui").input({
    prompt = prompt,
    default = default,
  }).input
end
