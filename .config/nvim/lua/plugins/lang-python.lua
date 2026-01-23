-- ~/.config/nvim/lua/plugins/lang-python.lua

return {
  -- Enable the LazyVim Python "extra".
  { import = "lazyvim.plugins.extras.lang.python" },

  -- Python tooling.
  -- Commented entries are installed system-wide; uncomment to use Mason instead.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "debugpy", -- debug adapter
        -- "ty",   -- type checker & LSP (system-wide)
        -- "ruff", -- linter & formatter (system-wide)
        -- "mypy", -- type checker for CI (system-wide)
      },
    },
  },

  -- Customize the neotest plugin for Python testing.
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
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
        python = { "ruff_format" },
      },
    },
  },

  -- Disable pyright (we're using ty instead).
  -- ty and ruff are installed system-wide, not via Mason.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = { enabled = false },
        ty = { mason = false },
        ruff = { mason = false },
      },
    },
  },
}
