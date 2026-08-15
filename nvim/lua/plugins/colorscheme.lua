vim.pack.add({
  "https://github.com/ribru17/bamboo.nvim",
  "https://github.com/catppuccin/nvim",
  "https://github.com/neanias/everforest-nvim",
  "https://github.com/kepano/flexoki-neovim",
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/tahayvr/matteblack.nvim",
  "https://github.com/gthelding/monokai-pro.nvim",
  "https://github.com/shaunsingh/nord.nvim",
  "https://github.com/rose-pine/neovim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/bjarneo/aether.nvim",
  "https://github.com/bjarneo/hackerman.nvim",
  "https://github.com/bjarneo/ethereal.nvim",
  "https://github.com/xero/miasma.nvim",
  "https://github.com/bjarneo/vantablack.nvim",
  "https://github.com/bjarneo/white.nvim",
  "https://github.com/rebelot/kanagawa.nvim",
})

local omarchy_theme_file = vim.fs.joinpath(vim.env.HOME, ".local", "state", "omarchy", "current", "theme", "neovim.lua")
local omarchy_current_dir = vim.fs.dirname(vim.fs.dirname(omarchy_theme_file))
local fallback_colorscheme = "tokyonight-night"
local theme_watcher
local sync_scheduled = false

local function apply_colorscheme(colorscheme)
  local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
  if not ok then
    vim.notify("Could not apply colorscheme '" .. colorscheme .. "': " .. tostring(err), vim.log.levels.WARN)
  end
  return ok
end

local function theme_definition()
  local chunk, err = loadfile(omarchy_theme_file)
  if not chunk then
    return nil, err
  end

  local ok, definition = pcall(chunk)
  if not ok or type(definition) ~= "table" then
    return nil, definition
  end

  return definition
end

local function load_theme_plugins(definition)
  for _, spec in ipairs(definition) do
    local source = spec[1]
    if type(source) == "string" and source ~= "LazyVim/LazyVim" then
      local url = source:match("^https?://") and source or "https://github.com/" .. source
      local ok, err = pcall(vim.pack.add, { url })
      if not ok then
        vim.notify("Could not load Omarchy theme plugin '" .. source .. "': " .. tostring(err), vim.log.levels.WARN)
        return false
      end
    end
  end

  return true
end

local function apply_theme_options(definition)
  for _, spec in ipairs(definition) do
    if spec[1] == "bjarneo/aether.nvim" and spec.opts then
      require("aether").setup(spec.opts)
    elseif spec[1] == "catppuccin/nvim" and spec.opts then
      require("catppuccin").setup(spec.opts)
    elseif spec[1] == "neanias/everforest-nvim" and spec.opts then
      require("everforest").setup(spec.opts)
    end
  end
end

local function colorscheme_name(definition)
  for _, spec in ipairs(definition) do
    if spec.opts and spec.opts.colorscheme then
      return spec.opts.colorscheme, spec.opts
    end
  end
end

local function sync_omarchy_theme()
  if not vim.uv.fs_stat(omarchy_theme_file) then
    return apply_colorscheme(fallback_colorscheme)
  end

  local definition, err = theme_definition()
  if not definition then
    vim.notify("Could not read Omarchy theme: " .. tostring(err), vim.log.levels.WARN)
    return
  end

  if not load_theme_plugins(definition) then
    return apply_colorscheme(fallback_colorscheme)
  end

  apply_theme_options(definition)
  local colorscheme, opts = colorscheme_name(definition)
  if not colorscheme then
    vim.notify(
      "Omarchy theme does not define a Neovim colorscheme; using " .. fallback_colorscheme,
      vim.log.levels.WARN
    )
    return apply_colorscheme(fallback_colorscheme)
  end

  if colorscheme == "everforest" and opts.background then
    require("everforest").setup({ background = opts.background })
  end

  if not apply_colorscheme(colorscheme) and colorscheme ~= fallback_colorscheme then
    return apply_colorscheme(fallback_colorscheme)
  end
end

vim.api.nvim_create_user_command("OmarchyThemeSync", sync_omarchy_theme, {
  desc = "Reload the current Omarchy theme",
})

sync_omarchy_theme()

if vim.uv.fs_stat(omarchy_current_dir) then
  theme_watcher = assert(vim.uv.new_fs_event())
  theme_watcher:start(omarchy_current_dir, {}, function(_, filename)
    -- Quattro atomically replaces the whole `theme` directory, so watch its
    -- parent instead of the generated file that disappears during a switch.
    if (filename ~= "theme" and filename ~= "theme.name") or sync_scheduled then
      return
    end

    sync_scheduled = true
    vim.schedule(function()
      sync_scheduled = false
      sync_omarchy_theme()
    end)
  end)
end

require("monokai-pro").setup({
  filter = "ristretto",
  override = function()
    return {
      NonText = { fg = "#948a8b" },
      MiniIconsGrey = { fg = "#948a8b" },
      MiniIconsRed = { fg = "#fd6883" },
      MiniIconsBlue = { fg = "#85dacc" },
      MiniIconsGreen = { fg = "#adda78" },
      MiniIconsYellow = { fg = "#f9cc6c" },
      MiniIconsOrange = { fg = "#f38d70" },
      MiniIconsPurple = { fg = "#a8a9eb" },
      MiniIconsAzure = { fg = "#a8a9eb" },
      MiniIconsCyan = { fg = "#85dacc" },
    }
  end,
})
