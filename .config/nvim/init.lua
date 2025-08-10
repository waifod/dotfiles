-- ~/.config/nvim/init.lua

-- This is the main entry point for the Neovim configuration.
-- Its sole purpose is to bootstrap lazy.nvim and load the configuration.

-- Set up the path to lazy.nvim.
local lazypath = vim.fn.stdpath("data").. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- Use the stable branch of lazy.nvim
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load the LazyVim configuration.
-- The `lazy.lua` file in `lua/config/` will handle the rest of the setup.
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
})
