-- Options are automatically loaded before lazy.nvim startup
-- It sets global options and variables.
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set the leader key BEFORE any plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable format-on-save globally.
-- This can be overridden on a per-buffer or per-filetype basis.
vim.g.autoformat = true

-- Standard Neovim options for a modern editing experience.
local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide markdown syntax, etc.
opt.confirm = true -- Confirm to save changes before quitting
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- A good default set of formatting options
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case in search patterns
opt.inccommand = "split" -- Show replacements in a split
opt.laststatus = 3 -- Only a global statusline
opt.list = true -- Show some invisible characters
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a" -- Enable mouse support
opt.number = true -- Print the line number
opt.pumheight = 10 -- Maximum number of items in completion menu
opt.relativenumber = false -- Show absolute line numbers
opt.scrolloff = 8 -- Lines of context around the cursor
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- Don't show the mode, lualine will do it
opt.sidescrolloff = 8 -- Columns of context around the cursor
opt.signcolumn = "yes" -- Always show the signcolumn
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces a <Tab> is worth
opt.termguicolors = true -- Enable 24-bit RGB color
opt.timeoutlen = 300 -- Lower timeout for keymaps to trigger faster
opt.undofile = true -- Save undo history
opt.undolevels = 10000
opt.updatetime = 200 -- Time in ms to wait for trigger
opt.wrap = false -- Disable line wrapping
opt.winbar = "%=%m %f" -- Display filename at the top of each split;

-- Enable smooth scrolling for Neovim 0.10+
if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end
