return {
  -- Add a custom keybinding for "Find Plugin File" to Telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    -- Override some Telescope options
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        file_ignore_patterns = { "node_modules" },
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
          preview_cutoff = 120,
        },
      },
    },
  },

  -- Change trouble config
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  -- Override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- Add extra language support via LazyVim's extras
  {
    "LazyVim/LazyVim",
    opts = {
      extras = {
        -- add typescript, treesitter, lspconfig and mason
        "lazyvim.plugins.extras.lang.typescript",
        -- add json, json5 and jsonc support, lspconfig and schemastore
        "lazyvim.plugins.extras.lang.json",
      },
    },
  },

  -- Override nvim-treesitter to add extra parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "tsx",
        "typescript",
        "java",
        "json",
        "json5",
        "jsonc",
      },
      auto_install = true,
    },
  },

  -- Configure mason to ensure specific tools are installed
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "jdtls",
        "pyright",
        "typescript-language-server",
        "rust-analyzer",
      },
    },
  },

  -- Configure auto-session to restore sessions
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    },
  },

  -- Configure conform.nvim for formatting. This replaces your autocmd.lua.
  -- LazyVim already includes and configures `conform.nvim`. We just override it.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        java = { "prettier" },
        -- Disable auto-formatting for java as requested
        -- To enable it, you'd configure it here.
        -- We'll just leave it out to disable it.
      },
    },
  },
}
