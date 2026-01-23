-- ~/.config/nvim/lua/plugins/lang-rust.lua

return {
  -- Enable the LazyVim Rust "extra".
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- Rust tooling.
  -- Commented entries are installed system-wide; uncomment to use Mason instead.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb", -- debug adapter
        -- "rust-analyzer", -- LSP (system-wide via rustup)
      },
    },
  },

  -- Prevent LazyVim from auto-installing rust-analyzer via Mason (installed via rustup).
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = { mason = false },
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
