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

  -- Add the tmux navigation plugin.
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true, -- defaults to false
      })
    end,
  },
}
