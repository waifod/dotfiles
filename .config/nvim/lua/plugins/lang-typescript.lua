-- ~/.config/nvim/lua/plugins/lang-typescript.lua

return {
  -- Enable the LazyVim TypeScript "extra".
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- Ensure TypeScript tools are installed by Mason.
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "prettierd",
        "eslint_d",
      },
    },
  },

  -- Configure formatting for TypeScript files.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettierd" },
        ["javascriptreact"] = { "prettierd" },
        ["typescript"] = { "prettierd" },
        ["typescriptreact"] = { "prettierd" },
        ["vue"] = { "prettierd" },
        ["css"] = { "prettierd" },
        ["scss"] = { "prettierd" },
        ["html"] = { "prettierd" },
        ["json"] = { "prettierd" },
        ["yaml"] = { "prettierd" },
        ["markdown"] = { "prettierd" },
      },
    },
  },
}
