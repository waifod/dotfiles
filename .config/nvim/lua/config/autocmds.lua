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

-- Tell tmux this pane is running nvim, so vim-tmux-navigator forwards
-- C-h/j/k/l instead of switching panes. tmux cannot detect nvim itself when
-- the pane's shell runs under Kiro's `kiro-cli-term` wrapper (see the
-- @vim_navigator_check comment in ~/.config/tmux/tmux.conf).
if vim.env.TMUX and vim.env.TMUX_PANE then
  local function set_pane_is_vim(on)
    local args = on and { "tmux", "set-option", "-p", "-t", vim.env.TMUX_PANE, "@pane_is_vim", "1" }
      or { "tmux", "set-option", "-p", "-u", "-t", vim.env.TMUX_PANE, "@pane_is_vim" }
    -- Synchronous on the way out: nvim may exit before an async job runs.
    local job = vim.system(args)
    if not on then
      job:wait(500)
    end
  end
  -- This file loads on VeryLazy, after VimEnter, so set the flag now.
  set_pane_is_vim(true)
  autocmd("VimResume", { group = my_augroup, callback = function() set_pane_is_vim(true) end })
  autocmd({ "VimLeavePre", "VimSuspend" }, { group = my_augroup, callback = function() set_pane_is_vim(false) end })
end
