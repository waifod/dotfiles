return {
  -- Learn Vim motions
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },

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

  -- Override neo-tree to display it on the right
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },

  -- Override nvim-treesitter to add extra parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "html",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "vimdoc",
        "yaml",
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

  -- Autosave files periodically
  {
    "pocco81/auto-save.nvim",
    -- Lazy load on certain events
    event = { "InsertLeave", "TextChanged" },
    config = function()
      require("auto-save").setup({
        -- Add your custom options here
        -- For example, to change the debounce delay:
        debounce_delay = 500, -- in milliseconds
        -- To silence the save message:
        execution_message = {
          message = function()
            return ""
          end,
          cleaning_interval = 0,
        },
      })
    end,
  },

  -- Plugin specification for codecompanion.nvim
  {
    "olimorris/codecompanion.nvim",
    -- Essential dependencies for codecompanion.nvim
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- Configuration function executed after the plugin is loaded
    config = function()
      require("codecompanion").setup({
        -- Configure specific LLM adapters
        adapters = {
          -- Configuration for the Gemini adapter
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              -- Specify the official Gemini 2.5 Pro model identifier
              model = "gemini-2.5-pro",
              -- The GEMINI_API_KEY environment variable will be automatically
              -- detected and used by codecompanion.nvim's default behavior.[2]
              -- For explicit control or if using a different environment variable name,
              -- you could uncomment and use the 'env' table:
              -- env = {
              --   api_key = vim.env.GEMINI_API_KEY, -- Or vim.env.YOUR_CUSTOM_GEMINI_ENV_VAR
              -- },
            })
          end,
        },
        -- Optionally, set default strategies to use the Gemini adapter
        -- This ensures Gemini is the default for chat and inline interactions.
        strategies = {
          chat = {
            adapter = "gemini",
          },
          inline = {
            adapter = "gemini",
          },
        },
        -- Optional: Enable debug logging for detailed troubleshooting.
        -- Uncomment the 'opts' table below to activate.
        -- opts = {
        --   log_level = "DEBUG", -- Set to "TRACE" for even more verbose logging [1]
        -- },
      })
    end,
  },
}
