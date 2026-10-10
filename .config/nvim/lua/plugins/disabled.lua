return {
  { "folke/noice.nvim", enabled = false },
  -- Sessions are handled by auto-session (lua/plugins/core.lua), which restores
  -- them automatically when nvim starts; tmux-resurrect relies on that.
  { "folke/persistence.nvim", enabled = false },
}
