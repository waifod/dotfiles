-- ~/.config/nvim/lua/plugins/lang-rust.lua

return {
  -- Enable the LazyVim Rust "extra".
  -- This will install and configure rustaceanvim, rust-analyzer, and codelldb.
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- Ensure rust-analyzer and codelldb are installed by Mason.
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "codelldb",
      },
    },
  },

  -- Customize the rustaceanvim plugin.
  -- This is the central point for all Rust-related configuration.
  {
    "mrcjkb/rustaceanvim",
    -- The version is managed by the LazyVim extra to ensure compatibility.
    -- No need to specify it here unless overriding.
    dependencies = { "mason.nvim" },
    opts = {
      -- The `server` table contains the settings passed to rust-analyzer.
      server = {
        -- The `on_attach` function is preserved from the extra, which sets up
        -- useful keymaps like <leader>cR for code actions. We can extend it if needed.

        -- The `default_settings` table is where we configure rust-analyzer itself.
        -- These settings are merged with the defaults from the extra.
        settings = {
          ["rust-analyzer"] = {
            -- Example: Enable the 'unresolved-proc-macro' diagnostic for nightly toolchains.
            -- This can be useful for debugging procedural macros.
            diagnostics = {
              enable = true,
              disabled = { "unresolved-proc-macro" },
            },

            -- Customize the check command to run clippy instead of check.
            check = {
              command = "clippy",
            },

            -- Add experimental features if desired.
            experimental = {
              procAttrMacros = true,
            },
          },
        },
      },
    },
  },
}
