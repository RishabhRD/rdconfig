RELOAD "el"
require("el").reset_windows()

local builtin = require "el.builtin"
local extensions = require "el.extensions"
local sections = require "el.sections"
local subscribe = require "el.subscribe"
local lsp_statusline = require "el.plugins.lsp_status"
local lsp_status = require "lsp-status"

local diag_count = function(_, bufnr)
  local all_diag = lsp_status.diagnostics(bufnr.bufnr)

  local res = ""
  if all_diag.errors ~= 0 then
    if res == "" then
      res = string.format(" %d", all_diag.errors)
    else
      res = string.format("%s  %d", res, all_diag.errors)
    end
  end
  if all_diag.warnings ~= 0 then
    if res == "" then
      res = string.format(" %d", all_diag.warnings)
    else
      res = string.format("%s  %d", res, all_diag.warnings)
    end
  end
  if all_diag.info ~= 0 then
    if res == "" then
      res = string.format("🛈 %d", all_diag.info)
    else
      res = string.format("%s 🛈 %d", res, all_diag.info)
    end
  end
  if all_diag.hints ~= 0 then
    if res == "" then
      res = string.format("!%d", all_diag.hints)
    else
      res = string.format("%s !%d", res, all_diag.hints)
    end
  end
  if res ~= "" then
    res = string.format("[%s]", res)
  end

  return res
end

local git_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
  local icon = extensions.file_icon(_, bufnr)
  if icon then
    return icon .. " "
  end

  return ""
end)

local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
  local branch = extensions.git_branch(window, buffer)
  if branch then
    return " " .. extensions.git_icon() .. " " .. branch
  end
end)

local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
  return extensions.git_changes(window, buffer)
end)

local show_current_func = function(window, buffer)
  if buffer.filetype == "lua" then
    return ""
  end

  return lsp_statusline.current_function(window, buffer)
end

local server_progress = function(win, buffer)
  local status = lsp_statusline.server_progress(win, buffer)
  if status == "" then
    return ""
  else
    return string.format("[%s]", status)
  end
end

require("el").setup {
  generator = function(--[[ window, buffer ]])
    local mode = extensions.gen_mode { format_string = " %s " }

    local items = {
      { mode, required = true },
      { git_branch },
      { " " },
      { sections.split, required = true },
      { git_icon },
      { sections.maximum_width(builtin.make_responsive_file(140, 90), 0.40), required = true },
      { sections.collapse_builtin { { " " }, { builtin.modified_flag } } },
      { sections.split, required = true },
      -- { show_current_func },
      { server_progress },
      { diag_count },
      { git_changes },
      { "[" },
      { builtin.line_with_width(3) },
      { ":" },
      { builtin.column_with_width(2) },
      { "]" },
      {
        sections.collapse_builtin {
          "[",
          builtin.help_list,
          builtin.readonly_list,
          "]",
        },
      },
      { builtin.filetype },
    }

    local add_item = function(result, item)
      table.insert(result, item)
    end

    local result = {}
    for _, item in ipairs(items) do
      add_item(result, item)
    end

    return result
  end,
}
