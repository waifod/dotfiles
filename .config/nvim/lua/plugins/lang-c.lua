-- ~/.config/nvim/lua/plugins/lang-c.lua

return {
  -- C/C++ tooling.
  -- Commented entries are installed system-wide; uncomment to use Mason instead.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- "clangd",    -- LSP (system-wide)
        -- "clang-format", -- formatter (system-wide, part of llvm/clang)
      },
    },
  },

  -- Use system-wide clangd, not Mason.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = { mason = false },
      },
    },
  },
}
