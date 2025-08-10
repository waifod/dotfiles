-- ~/.config/nvim/lua/plugins/lang-typescript.lua

return {
  -- Enable the LazyVim TypeScript "extra".
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- Ensure the TypeScript LSP server and Prettier formatter are installed.
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "prettierd", -- Use the daemonized version of Prettier for speed.
        "eslint_d", -- Use the daemonized version of ESLint for speed.
      },
    },
  },

  -- Customize nvim-lspconfig for tsserver.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Configure the TypeScript Language Server.
        tsserver = {
          -- Add custom keymaps that will only be active in TypeScript buffers
          -- attached to tsserver.
          keys = {
            -- Example: Add a keymap for the "Go to Source Definition" command,
            -- which is useful in projects with declaration files (.d.ts).
            {
              "gS",
              function()
                require("typescript").goToSourceDefinition()
              end,
              desc = "Go to Source Definition",
            },
          },
        },
        -- Configure ESLint as a separate LSP for more robust linting.
        eslint = {
          -- ESLint settings can be configured here if needed.
        },
      },
      -- The setup function from the extra handles attaching typescript.nvim commands.
      -- We don't need to override it unless we have very specific needs.
    },
  },

  -- Configure formatting for TypeScript files.
  {
    "stevearc/conform.nvim",
    opts = {
      -- Define formatters for different filetypes.
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
