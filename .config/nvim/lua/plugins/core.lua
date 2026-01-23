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
    opts = {},
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
        "json",
        "json5",
        "jsonc",
      },
      auto_install = true,
    },
  },

  -- Configure mason to ensure specific tools are installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
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
}
