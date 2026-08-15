vim.g.mapleader = " "
vim.o.winborder = "rounded"

local opt = vim.opt

opt.wrap = true
opt.linebreak = true
opt.autoread = true
opt.undofile = true
opt.swapfile = false
opt.backup = false

opt.colorcolumn = "80"

opt.softtabstop = 2
opt.shiftwidth = 2

opt.inccommand = "split"
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.termguicolors = true

opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.splitbelow = true
opt.splitright = true
opt.showcmd = true
opt.signcolumn = "yes"
opt.mouse = "a"

opt.scrolloff = 10
-- vim.filetype.add {
--   extension = {
--     hylo = "hylo",
--   },
-- }

opt.exrc = true

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update(nil, { force = true })
end, {
  desc = "Update all plugins",
})

vim.api.nvim_create_user_command("PackDeleteInactive", function()
  local inactive = vim.tbl_filter(function(plugin)
    return not plugin.active
  end, vim.pack.get())

  if #inactive > 0 then
    vim.pack.del(vim.tbl_map(function(plugin)
      return plugin.spec.name
    end, inactive))
  end
end, {
  desc = "Remove inactive plugins",
})
