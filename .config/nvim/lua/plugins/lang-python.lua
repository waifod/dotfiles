-- ~/.config/nvim/lua/plugins/lang-python.lua

return {
  -- Enable the LazyVim Python "extra".
  { import = "lazyvim.plugins.extras.lang.python" },

  -- Ensure Python tools are installed by Mason.
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright", -- Can be installed via the system; if so, comment this line
        "ruff", -- The ruff language server can be installed via the system; if so, comment this line
        "debugpy", -- The Python debug adapter can be installed via the system; if so, comment this line
      },
    },
  },

  -- Customize the neotest plugin for Python testing.
  {
    "nvim-neotest/neotest",
    optional = true, -- This plugin is optional, only loaded if neotest is used.
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Configure the test runner to use pytest.
          runner = "pytest",
          -- IMPORTANT: This tells neotest how to find the Python executable.
          -- It's crucial for projects using virtual environments.
          -- This example function looks for common venv paths.
          python = function()
            local venv = vim.fn.findfile("pyproject.toml", ".;")
            if venv ~= "" then
              venv = vim.fn.fnamemodify(venv, ":h")
              if vim.fn.isdirectory(venv .. "/.venv") then
                return venv .. "/.venv/bin/python"
              elseif vim.fn.isdirectory(venv .. "/venv") then
                return venv .. "/venv/bin/python"
              end
            end
            return "python"
          end,
        },
      },
    },
  },

  -- Customize the conform.nvim plugin for Python formatting.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Use ruff as the primary formatter for Python.
        python = { "ruff_format" },
      },
    },
  },

  -- Customize nvim-lspconfig for Python servers.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Configure pyright with specific settings.
        pyright = {
          settings = {
            python = {
              analysis = {
                -- Example: Set type checking mode. "basic", "strict".
                typeCheckingMode = "basic",
                -- Example: Add custom paths for type stubs.
                -- stubPath = "./stubs",
              },
            },
          },
        },
        -- Configure ruff_lsp.
        ruff_lsp = {
          -- The extra already configures ruff to handle import organization.
          -- Custom settings can be added here if needed.
        },
      },
    },
  },
}
