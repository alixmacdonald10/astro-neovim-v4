-- Customize Mason plugins
-- taken from the wondeful example at https://github.com/A-Lamia/AstroNvim-conf/blob/main/plugins/dap.lua

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "lua_ls",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "prettier",
        "stylua",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",
        "codelldb",
      })
    end,

    config = function()
      local dap = require "dap"
      local fn = require "utils.fn"
      local telescope = require "utils.telescope"

      -- rust
      local CODELLDB_DIR = require("mason-registry").get_package("codelldb"):get_install_path()
        .. "/extension/adapter/codelldb"

      local function set_program()
        local function set_path(prompt_bufnr, map)
          telescope.actions.select_default:replace(function()
            telescope.actions.close(prompt_bufnr)
            local selected = telescope.actions_state.get_selected_entry()
            vim.g.dap_program = selected.path
          end)
          return true
        end
        telescope.run_func_on_file {
          name = "Executable",
          attach_mappings = set_path,
          results = fn.get_files_by_end,
          results_args = fn.is_win() and "exe" or "",
        }
        return true
      end

      require("astrocore").set_mappings {
        n = {
          ["<leader>de"] = { set_program, desc = "Set program path" },
        },
      }

      dap.adapters.codelldb = {
        name = "codelldb",
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = CODELLDB_DIR,
          args = { "--port", "${port}" },
        },
        detatched = false,
      }

      dap.configurations.rust = {
        {
          name = "Launch selected target",
          type = "codelldb",
          request = "launch",
          program = function()
            if not vim.g.dap_program or #vim.g.dap_program == 0 then
              vim.g.dap_program =
                vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end
            return vim.g.dap_program
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {}
        },
      }
    end,
  },
}
