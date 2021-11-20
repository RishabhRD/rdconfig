local M = {}

function M.transform_v(tbl, func)
  local res = {}
  for k, v in pairs(tbl) do
    res[k] = func(v)
  end
  return res
end

function M.transform_k(tbl, func)
  local res = {}
  for k, v in pairs(tbl) do
    res[func(k)] = v
  end
  return res
end

return M
