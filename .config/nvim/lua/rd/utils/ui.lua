local function input(opts)
  local co = coroutine.running()
  assert(co, "must be running under a coroutine")

  vim.ui.input(opts, function(str)
    coroutine.resume(co, str)
  end)

  return { input = coroutine.yield() }
end

return {
  input = input,
}
