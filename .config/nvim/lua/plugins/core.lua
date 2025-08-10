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

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Ensures parsers are updated
      -- Optional: If a completion plugin like blink.cmp is used, ensure codecompanion is a source
      -- {
      --   "saghen/blink.cmp",
      --   lazy = false, -- Or "VeryLazy" for later loading
      --   version = "*",
      --   opts = {
      --     sources = {
      --       default = { "lsp", "path", "buffer", "codecompanion" }, -- Include codecompanion as a completion source
      --     },
      --   },
      -- },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "huggingface_gemma3", -- Assign a custom name for the adapter
        },
        -- 'inline' strategy for direct code suggestions
        inline = {
          adapter = "huggingface_gemma3",
        },
      },
      adapters = {
        huggingface_gemma3 = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              -- IMPORTANT: Replace with the actual Hugging Face Inference Endpoint URL.
              -- Ensure the URL includes the /v1/ suffix if provided by Hugging Face.
              url = os.getenv("HF_INFERENCE_ENDPOINT_URL"), -- Base URL read from environment variable
              chat_url = "/v1/chat/completions", -- Standard OpenAI chat completions endpoint path
              api_key = os.getenv("HF_TOKEN"), -- Hugging Face User Access Token read from environment variable
            },
            name = "huggingface_gemma3", -- The name of this custom adapter
            schema = {
              model = {
                choices = { "google/gemma-3-27b-it" }, -- Specify the exact model ID
                default = "google/gemma-3-27b-it", -- Set as the default model
              },
              temperature = {
                default = 0.7, -- Controls randomness: 0.0 (deterministic) to 2.0 (highly random)
                min = 0,
                max = 2,
                step = 0.1,
                desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.",
              },
              max_tokens = {
                default = 4096, -- Maximum number of tokens for the model's response
                min = 1,
                max = 8192, -- Adjust based on Gemma3's context window and endpoint limits
                desc = "The maximum number of tokens to generate in the chat completion.",
              },
              -- Other parameters supported by the OpenAI-compatible API and Gemma3 can be added here,
              -- such as top_p, frequency_penalty, presence_penalty, stop sequences, etc.
            },
          })
        end,
      },
      -- Optional: Enable debug logging for detailed troubleshooting (see Section 7)
      opts = {
        log_level = "DEBUG",
      },
    },
    -- Ensure nvim-treesitter is set up to highlight markdown/markdown_inline.
    -- This setup might reside in a separate LazyVim configuration file (e.g., lua/plugins/treesitter.lua),
    -- but its presence is crucial for codecompanion.nvim's functionality.
    -- Example (if placed directly here, though usually separate in LazyVim):
    -- local ts_status, treesitter = pcall(require, "nvim-treesitter.configs")
    -- if ts_status then
    --   treesitter.setup({
    --     ensure_installed = { "lua", "markdown", "markdown_inline", "yaml" },
    --     highlight = { enable = true },
    --   })
    -- end
  },
}
