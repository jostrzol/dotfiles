-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    ---@type AstroLSPOpts
    local local_opts = {
      -- Configure core features of AstroNvim
      features = {
        large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
        autopairs = true, -- enable autopairs at start
        cmp = true, -- enable completion at start
        diagnostics_modk = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
        highlighturl = true, -- highlight URLs at start
        notifications = true, -- enable notifications at start
        signature_help = true,
      },
      -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
      diagnostics = {
        virtual_text = true,
        underline = true,
      },
      -- vim options can be configured here
      options = {
        opt = { -- vim.opt.<key>
          relativenumber = false, -- sets vim.opt.relativenumber
          number = true, -- sets vim.opt.number
          spell = false, -- sets vim.opt.spell
          signcolumn = "yes", -- sets vim.opt.signcolumn to yes
          wrap = true, -- sets vim.opt.wrap
          scrolloff = 5,
        },
        g = { -- vim.g.<key>
          -- configure global vim variables (vim.g)
          -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
          -- This can be found in the `lua/lazy_setup.lua` file
        },
      },

      -- vim.api.nvim_create_user_command('Redir', function(ctx)
      --   local lines = vim.split(vim.api.nvim_exec(ctx.args, true), '\n', { plain = true })
      --   vim.cmd('enew')
      --   vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      --   vim.opt_local.modified = false
      -- end, { nargs = '+', complete = 'command' })
      commands = {
        Redir = {
          function(ctx)
            local lines = vim.split(vim.api.nvim_exec(ctx.args, true), "\n", { plain = true })
            vim.cmd "enew"
            vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
            vim.opt_local.modified = false
          end,
          nargs = "+",
          complete = "command",
        },
        LspClear = {
          function(_)
            local log_path = vim.fn.glob(vim.fn.stdpath "state" .. "/lsp.log")
            local file, err = io.open(log_path, "w")
            assert(file, err)

            local _, err2 = file:write ""
            assert(err2 == nil, err2)
          end,
        },
      },
      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map

          -- navigate buffer tabs
          ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          ["<C-M-h>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          ["<C-M-l>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },

          -- mappings seen under group name "Buffer"
          ["<Leader>bd"] = {
            function()
              require("astroui.status.heirline").buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Close buffer from tabline",
          },

          -- tables with just a `desc` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          -- ["<Leader>b"] = { desc = "Buffers" },

          -- setting a mapping to false will disable it
          -- ["<C-S>"] = false,

          ["<Leader><Leader>"] = { "<C-6>", desc = "Previous file" },

          -- close buffers remap: bl -> bh, br -> bl
          ["<Leader>bh"] = opts.mappings.n["<Leader>bl"],
          ["<Leader>bl"] = opts.mappings.n["<Leader>br"],
          ["<Leader>br"] = false,
        },
      },
    }

    return vim.tbl_deep_extend("force", opts, local_opts)
  end,
}
