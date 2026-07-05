local std = require("std")

local autoformat_global_disabled = false
local autoformat_disabled_buffers = {}
local hunk_based_formatting = true

local remove_trailing_whitespace_for = {
  text = true,
  markdown = true,
}

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

local function hunk_formatting_enable()
  hunk_based_formatting = true
end

local function hunk_formatting_disable()
  hunk_based_formatting = false
end

local function can_autoformat_with_buf(buf)
  return autoformat_disabled_buffers[buf] == nil
end

local function fname_compare(noformat_file, fname)
  -- netrw sometimes opens project files with absolute path
  return (fname == noformat_file) or (fname == std.to_absolute(noformat_file))
end

local function can_autoformat_with_file(fname)
  return std.contains_in_array(std.lines_from(".noformat"), fname, fname_compare) == false
end

local function can_autoformat(buf, fname)
  return can_autoformat_with_buf(buf) and can_autoformat_with_file(fname)
end

local format = function()
  if not is_autoformat_disabled_globally() then
    if can_autoformat(vim.api.nvim_get_current_buf(), std.current_file_name()) then
      local format = require("conform").format
      if hunk_based_formatting then
        local hunks = require("gitsigns").get_hunks()
        if hunks == nil then
          format({ lsp = "fallback" })
        else
          for i = #hunks, 1, -1 do
            local hunk = hunks[i]
            if hunk ~= nil and hunk.type ~= "delete" then
              local start = hunk.added.start
              local last = start + hunk.added.count
              -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
              local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
              local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
              format({ range = range })
            end
          end
        end
      else
        format({ lsp = "fallback" })
      end
      if remove_trailing_whitespace_for[vim.bo.filetype] then
        vim.cmd([[%s/\s\+$//e]])
      end
    end
  end
end

local function setup()
  vim.cmd([[command! AutoFormatEnableGlobal lua require'rd.autoformat'.autoformat_enable_global()]])
  vim.cmd([[command! AutoFormatDisableGlobal lua require'rd.autoformat'.autoformat_disable_global()]])
  vim.cmd([[command! HunkFormattingEnable lua require'rd.autoformat'.hunk_formatting_enable()]])
  vim.cmd([[command! HunkFormattingDisable lua require'rd.autoformat'.hunk_formatting_disable()]])

  std.nmap("<leader>fd", function()
    autoformat_disable(vim.api.nvim_get_current_buf())
    print("Autoformat disabled for buffer ", vim.api.nvim_get_current_buf())
  end)
  std.nmap("<leader>fe", function()
    autoformat_enable(vim.api.nvim_get_current_buf())
    print("Autoformat enabled for buffer ", vim.api.nvim_get_current_buf())
  end)

  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = format,
    group = vim.api.nvim_create_augroup("Formatter", { clear = true }),
  })
end

return {
  autoformat_enable_global = autoformat_enable_global,
  autoformat_disable_global = autoformat_disable_global,
  hunk_formatting_enable = hunk_formatting_enable,
  hunk_formatting_disable = hunk_formatting_disable,
  is_autoformat_disabled_globally = is_autoformat_disabled_globally,
  autoformat_enable = autoformat_enable,
  autoformat_disable = autoformat_disable,
  can_autoformat = can_autoformat,
  setup = setup,
  format = format,
}
