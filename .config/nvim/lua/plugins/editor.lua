-- ~/.config/nvim/lua/plugins/editor.lua

return {
  -- Add the gruvbox colorscheme plugin.
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to use gruvbox as the default colorscheme.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Add the tmux navigator plugin.
  {
    "alexghergh/nvim-tmux-navigation",
    -- This plugin is configured via its `config` function.
    config = function()
      require("nvim-tmux-navigation").setup({
        -- Disable navigation when a tmux pane is zoomed.
        disable_when_zoomed = true,
      })
      -- Set the keymaps for tmux navigation.
      -- These are set here because the plugin needs to be loaded first.
      -- The conflicting default keymaps have already been removed in `lua/config/keymaps.lua`.
      local nvim_tmux_nav = require("nvim-tmux-navigation")
      vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
    end,
  },
}
