-- ~/.config/nvim/lua/plugins/lang-rust.lua

return {
  -- Enable the LazyVim Rust "extra".
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- Ensure Rust tools are installed by Mason.
  -- Required: rust-analyzer (uncomment if not installed via rustup).
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- "rust-analyzer",
        "codelldb",
      },
    },
  },

  -- Customize the rustaceanvim plugin.
  {
    "mrcjkb/rustaceanvim",
    dependencies = { "mason.nvim" },
    opts = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
              disabled = { "unresolved-proc-macro" },
            },
            check = {
              command = "clippy",
            },
            experimental = {
              procAttrMacros = true,
            },
          },
        },
      },
    },
  },
}
