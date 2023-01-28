local function execute()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "buftype", "acwrite")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "delete")
  vim.api.nvim_buf_set_name(buf, "hello")
  local augroup_name = "BufWriteTest" .. buf
  local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
  vim.api.nvim_create_autocmd({ "BufWriteCmd" }, {
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      P(lines)
      vim.api.nvim_buf_set_option(buf, "modified", false)
    end,
    buffer = buf,
    group = group,
  })
  local width = vim.api.nvim_get_option "columns"
  local height = vim.api.nvim_get_option "lines"
  if width > 150 or height > 35 then
    local win_height = math.min(math.ceil(height * 3 / 4), 30)
    local win_width
    if width < 150 then
      win_width = math.ceil(width - 8)
    else
      win_width = math.ceil(width * 0.9)
    end
    local opts = {
      relative = "editor",
      width = win_width,
      height = win_height,
      row = math.ceil((height - win_height) / 2),
      col = math.ceil((width - win_width) / 2),
    }
    vim.api.nvim_open_win(buf, true, opts)
  end
end

execute()

-- local buf = vim.fn.bufnr "hello"
-- vim.api.nvim_buf_set_option(buf, "modified", false)
-- P(buf)
-- vim.api.nvim_buf_delete(buf, {})
