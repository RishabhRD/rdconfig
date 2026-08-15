vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
})

local omarchy_theme_file = vim.fs.joinpath(vim.env.HOME, ".local", "state", "omarchy", "current", "theme", "neovim.lua")

local omarchy_current_dir = vim.fs.dirname(vim.fs.dirname(omarchy_theme_file))
local extra_colorschemes_file = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins", "extra-colorschemes.lua")

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

local function persist_colorscheme(source)
  local url = source:match("^https?://") and source or "https://github.com/" .. source

  local contents = ""
  if vim.uv.fs_stat(extra_colorschemes_file) then
    contents = table.concat(vim.fn.readfile(extra_colorschemes_file), "\n")
  end

  if contents:find(url, 1, true) then
    return
  end

  local file = assert(io.open(extra_colorschemes_file, "a"))
  file:write("\nvim.pack.add({\n")
  file:write(('  "%s",\n'):format(url))
  file:write("})\n")
  file:close()
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

      persist_colorscheme(source)
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

local function apply_theme(definition)
  for _, spec in ipairs(definition) do
    local opts = spec.opts
    local colorscheme = opts and opts.colorscheme

    if type(colorscheme) == "string" then
      if spec[1] == "neanias/everforest-nvim" and opts.background then
        require("everforest").setup({
          background = opts.background,
        })
      end

      return apply_colorscheme(colorscheme)
    elseif type(colorscheme) == "function" then
      local ok, err = pcall(colorscheme)
      if not ok then
        vim.notify("Could not apply custom Omarchy colorscheme: " .. tostring(err), vim.log.levels.WARN)
        return false
      end

      return true
    end
  end

  return false
end

local function sync_omarchy_theme()
  if not vim.uv.fs_stat(omarchy_theme_file) then
    return apply_colorscheme(fallback_colorscheme)
  end

  local definition, err = theme_definition()
  if not definition then
    vim.notify("Could not read Omarchy theme: " .. tostring(err), vim.log.levels.WARN)
    return apply_colorscheme(fallback_colorscheme)
  end

  if not load_theme_plugins(definition) then
    return apply_colorscheme(fallback_colorscheme)
  end

  apply_theme_options(definition)

  if not apply_theme(definition) then
    vim.notify(
      "Omarchy theme does not define a valid Neovim colorscheme; using " .. fallback_colorscheme,
      vim.log.levels.WARN
    )

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
    -- Omarchy atomically replaces the whole `theme` directory, so watch its
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
