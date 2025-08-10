-- ~/.config/nvim/lua/config/lazy.lua

-- This file is automatically loaded by lazy.nvim
-- Do not require this file manually in your init.lua

require("lazy").setup({
  spec = {
    -- The first spec should be the LazyVim plugin itself.
    -- This imports all the default LazyVim plugins and configurations.
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- The second spec imports all of your custom plugins from the `lua/plugins/` directory.
    -- lazy.nvim automatically discovers and loads any.lua files in this directory.
    { import = "plugins" },
  },

  -- Configure lazy.nvim's default options.
  defaults = {
    -- It is recommended to leave versioning disabled (version = false).
    -- LazyVim is tested against the latest commits of its plugins, and many plugins
    -- do not use semantic versioning or have outdated stable releases.
    -- Using the latest git commit ensures maximum compatibility.
    version = false,

    -- By default, your custom plugins will be loaded eagerly.
    -- If you want to lazy-load all your plugins, you can set this to true.
    -- However, for clarity, it is often better to specify lazy-loading triggers
    -- on a per-plugin basis.
    lazy = false,
  },

  -- Pre-install some colorschemes to avoid a flash of unstyled content on startup.
  install = { colorscheme = { "gruvbox" } },

  -- Enable checking for plugin updates.
  checker = {
    enabled = true,
    notify = false, -- Don't notify on every update, check with :Lazy manually.
  },

  -- Configure performance options.
  performance = {
    rtp = {
      -- Disable some default Neovim plugins that are either replaced by
      -- more modern alternatives or are not commonly used.
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
