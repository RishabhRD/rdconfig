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

-- folding
opt.foldmethod = "marker"
opt.foldopen = opt.foldopen - "search"

opt.title = true
opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'
