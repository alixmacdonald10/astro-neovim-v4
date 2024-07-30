-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },

  -- themes and colours
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.color.transparent-nvim" },

  -- note taking
  { import = "astrocommunity.note-taking.global-note-nvim" },
  -- language packs
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.zig" },
  { import = "astrocommunity.pack.python" },
  {
    "mfussenegger/nvim-dap-python",
    enabled = true,
    dependencies = {},
    config = function()
      local dap = require "dap"
      local PYTHON_DIR = ".venv/Scripts/python"

      dap.adapters.python = {
        name = "python",
        type = "executable",
        command = PYTHON_DIR,
        args = { "-m", "debugpy.adapter" },
        detatched = false,
      }

      dap.configurations.python = {
        {
          name = "Run current file with args",
          type = "python",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          justMyCode = false,
          args = function()
            local arguments = vim.fn.input('Program arguments: ')
            return vim.split(arguments, " +")
          end,
        },
        {
          name = "Pytest: Current File with args",
          type = "python",
          request = "launch",
          module = "pytest",
          cwd = "${workspaceFolder}",
          args = function()
            local base_args = {
              "${file}",
            }
            local user_args_str = vim.fn.input('Enter additional arguments: ')
            local user_args = vim.split(user_args_str, "%s+", { trimempty = true })
            vim.list_extend(base_args, user_args)
            return base_args
          end,
          console = "integratedTerminal",
        },
        {
          name = "Pytest",
          type = "python",
          request = "launch",
          module = "pytest",
          cwd = "${workspaceFolder}",
          args = function()
            local base_args = {}
            local user_args_str = vim.fn.input('Enter additional arguments: ')
            local user_args = vim.split(user_args_str, "%s+", { trimempty = true }) vim.list_extend(base_args, user_args)
            return base_args
          end,
          console = "integratedTerminal",
        },
      }
    end
  },
  {
    "linux-cultist/venv-selector.nvim",
    config = function()
      require('venv-selector').setup {
        name = { ".venv", "venv" }
      }
    end,
  },
  { import = "astrocommunity.pack.html-css"},
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.helm" },
  { import = "astrocommunity.pack.full-dadbod" },
  -- debugging 
  { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },

  -- Markdown handling
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim"},

  -- code-runner

  -- other
  { import = "astrocommunity.media.vim-wakatime" },
}
