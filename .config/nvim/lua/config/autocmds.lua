-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Define a group for user-defined autocommands.
local my_augroup = augroup("MyAutocmds", { clear = true })

-- Disable auto-formatting for certain filetypes.
-- This implements the second layer of the format-on-save control hierarchy.
autocmd("FileType", {
  group = my_augroup,
  pattern = {
    "gitcommit",
    "java",
    "scala",
    "typescript",
    "markdown",
    "text",
    "help",
  },
  callback = function()
    -- Set the buffer-local variable to disable autoformatting.
    vim.b.autoformat = false
  end,
  desc = "Disable autoformat for specific filetypes",
})
