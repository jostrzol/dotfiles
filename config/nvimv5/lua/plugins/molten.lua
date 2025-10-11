---@type LazyPluginSpec
return {
  "benlubas/molten-nvim",
  init = function()
    -- I find auto open annoying, keep in mind setting this option will require
    -- setting a keybind for `:noautocmd MoltenEnterOutput` to open the output
    -- again
    vim.g.molten_auto_open_output = false
    vim.g.molten_image_provider = "image.nvim"
    vim.g.molten_wrap_output = true
    -- Output as virtual text. Allows outputs to always be shown, works with
    -- images, but can be buggy with longer images
    vim.g.molten_virt_text_output = true
    -- this will make it so the output shows up below the \`\`\` cell delimiter
    vim.g.molten_virt_lines_off_by_1 = true
  end,
  specs = {
    {
      "quarto-dev/quarto-nvim",
      ft = { "quarto", "markdown" },
      opts = {
        lspFeatures = {
          -- NOTE: put whatever languages you want here:
          languages = { "python" },
          chunks = "all",
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          -- NOTE: setup your own keymaps:
          hover = "K",
          definition = "gd",
          rename = "<Leader>lr",
          references = "gu",
          format = "<M-f>",
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        },
      },
    },
    {
      "jmbuhr/otter.nvim",
      opts = {
        lsp = {
          -- `:h events` that cause the diagnostics to update. Set to:
          -- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
          -- but more instant diagnostic updates
          diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
          -- function to find the root dir where the otter-ls is started
          root_dir = function(_, bufnr)
            return vim.fs.root(bufnr or 0, {
              ".git",
              "_quarto.yml",
              "package.json",
            }) or vim.fn.getcwd(0)
          end,
        },
        -- options related to the otter buffers
        buffers = {
          -- if set to true, the filetype of the otterbuffers will be set.
          -- otherwise only the autocommand of lspconfig that attaches
          -- the language server will be executed without setting the filetype
          --- this setting is deprecated and will default to true in the future
          set_filetype = true,
          -- write <path>.otter.<embedded language extension> files
          -- to disk on save of main buffer.
          -- usefule for some linters that require actual files.
          -- otter files are deleted on quit or main buffer close
          write_to_disk = false,
          -- a table of preambles for each language. The key is the language and the value is a table of strings that will be written to the otter buffer starting on the first line.
          preambles = {},
          -- a table of postambles for each language. The key is the language and the value is a table of strings that will be written to the end of the otter buffer.
          postambles = {},
          -- A table of patterns to ignore for each language. The key is the language and the value is a lua match pattern to ignore.
          -- lua patterns: https://www.lua.org/pil/20.2.html
          ignore_pattern = {
            -- ipython cell magic (lines starting with %) and shell commands (lines starting with !)
            python = "^(%s*[%%!].*)",
          },
        },
        -- list of characters that should be stripped from the beginning and end of the code chunks
        strip_wrapping_quote_characters = { "'", '"', "`" },
        -- remove whitespace from the beginning of the code chunks when writing to the ottter buffers
        -- and calculate it back in when handling lsp requests
        handle_leading_whitespace = true,
        -- mapping of filetypes to extensions for those not already included in otter.tools.extensions
        -- e.g. ["bash"] = "sh"
        extensions = {},
        -- add event listeners for LSP events for debugging
        debug = false,
        verbose = { -- set to false to disable all verbose messages
          no_code_found = false, -- warn if otter.activate is called, but no injected code was found
        },
      },
    },
    {
      "GCBallesteros/jupytext.nvim",
      opts = {
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      },
    },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            --- Molten
            -- ["<LocalLeader>e"] = { ":MoltenEvaluateOperator<CR>", desc = "evaluate operator", silent = true },
            -- ["<LocalLeader>rr"] = { ":MoltenReevaluateCell<CR>", desc = "re-eval cell", silent = true },
            ["<LocalLeader>i"] = { ":MoltenInit<CR>", desc = "Init kernel", silent = true },
            ["<LocalLeader>o"] = { ":noautocmd MoltenEnterOutput<CR>", desc = "Open output window", silent = true },
            ["<LocalLeader>h"] = { ":MoltenHideOutput<CR>", desc = "Close output window", silent = true },
            ["<LocalLeader>d"] = { ":MoltenDelete<CR>", desc = "Delete cell", silent = true },
            ["<LocalLeader>x"] = { ":MoltenOpenInBrowser<CR>", desc = "Open output in browser", silent = true },
            --- Quarto
            -- ["<LocalLeader>q"] = { nil, desc = "Quarto" },
            ["<LocalLeader>p"] = {
              function() require("quarto").quartoPreview {} end,
              desc = "Preview",
            },
            ["<LocalLeader>c"] = {
              function() require("quarto.runner").run_cell() end,
              desc = "Run cell",
              silent = true,
            },
            ["<LocalLeader>a"] = {
              function() require("quarto.runner").run_above() end,
              desc = "Run cell and above",
              silent = true,
            },
            ["<LocalLeader>A"] = {
              function() require("quarto.runner").run_all() end,
              desc = "Run all cells",
              silent = true,
            },
            ["<LocalLeader>l"] = {
              function() require("quarto.runner").run_line() end,
              desc = "Run line",
              silent = true,
            },
            ["<LocalLeader>m"] = {
              function() require("quarto.runner").run_all(true) end,
              desc = "Run all cells of all languages",
              silent = true,
            },
            -- ["]x"] = { "<Cmd>MoltenNext<CR>", desc = "Next Molten Cell" },
            -- ["[x"] = { "<Cmd>MoltenPrev<CR>", desc = "Previous Molten Cell" },
          },
          v = {
            --- Molten
            -- ["<LocalLeader>r"] = {
            --   ":<C-u>MoltenEvaluateVisual<CR>gv",
            --   desc = "execute visual selection",
            --   silent = true,
            -- },
            --- Quarto
            ["<LocalLeader>r"] = {
              function() require("quarto.runner").run_range() end,
              desc = "Run visual range",
              silent = true,
            },
          },
        },
      },
    },
    -- Make folds work for quarto
    {
      "kevinhwang91/nvim-ufo",
      opts = {
        filetype_attach = {
          quarto = true,
        },
      },
    },
    -- Formatting
    {
      "stevearc/conform.nvim",
      ---@type conform.setupOpts
      ft = { "quarto" },
      opts = {
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = function() end,
        format_after_save = function(bufnr)
          if vim.F.if_nil(vim.b[bufnr].autoformat, vim.g.autoformat, true) then return { lsp_format = "fallback" } end
        end,
        notify_on_error = true,
        notify_no_formatters = true,
        formatters_by_ft = {
          quarto = { "injected" },
        },
        formatters = {
          prettier = {
            options = {
              ext_parsers = {
                markdown_inline = "markdown",
              },
            },
          },
          injected = {
            options = {
              ignore_errors = false,
              -- Map of treesitter language to file extension
              -- A temporary file name with this extension will be generated during formatting
              -- because some formatters care about the filename.
              lang_to_ext = {
                bash = "sh",
                c_sharp = "cs",
                elixir = "exs",
                javascript = "js",
                julia = "jl",
                latex = "tex",
                markdown = "md",
                python = "py",
                ruby = "rb",
                rust = "rs",
                teal = "tl",
                r = "r",
                typescript = "ts",
              },
              -- Map of treesitter language to formatters to use
              -- (defaults to the value from formatters_by_ft)
              lang_to_formatters = {
                yaml = { "yamlfmt", lsp_format = "fallback" },
                markdown_inline = { "prettier" },
                markdown = { "prettierd" },
                lua = { "stylua" },
                python = { "isort", "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                sql = { "sqlfluff" },
              },
            },
          },
        },
        -- log_level = vim.log.levels.DEBUG,
      },
    },
    -- outline
    {
      "stevearc/aerial.nvim",
      opts = {
        backends = {
          -- Defaults:
          -- ["_"] = {}
          quarto = { "treesitter" },
        },
      },
    },
  },
}
