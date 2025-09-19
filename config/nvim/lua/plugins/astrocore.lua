-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    ---@type AstroCoreOpts
    local local_opts = {
      -- Configure core features of AstroNvim
      features = {
        large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
        autopairs = true, -- enable autopairs at start
        cmp = true, -- enable completion at start
        diagnostics_modk = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
        highlighturl = true, -- highlight URLs at start
        notifications = true, -- enable notifications at start
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
          spelllang = "pl,en",
          spellfile = vim.fn.stdpath "data" .. "/spell/pl.utf-8.add",
        },
        g = { -- vim.g.<key>
          -- configure global vim variables (vim.g)
          -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
          -- This can be found in the `lua/lazy_setup.lua` file
        },
      },
      commands = {
        Redir = {
          function(ctx)
            local result = vim.api.nvim_exec2(ctx.args, { output = true })
            local lines = vim.split(result.output, "\n", { plain = true })
            local buf = vim.api.nvim_create_buf(true, true)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.api.nvim_buf_set_name(buf, ctx.args)
            local filetype = vim.filetype.match { buf = buf }
            vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })
            vim.api.nvim_set_current_buf(buf)
          end,
          nargs = "+",
          complete = "command",
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

          -- Move line up/down
          ["<M-k>"] = { "<cmd>m -2<cr>", desc = "Move line up" },
          ["<M-j>"] = { "<cmd>m +1<cr>", desc = "Move line down" },

          -- Unbind home screen
          ["<Leader>h"] = false,

          -- Find in manpages (modified to include all sections)
          ["<Leader>fm"] = {
            function() require("telescope.builtin").man_pages { sections = { "ALL" } } end,
            desc = "Find man",
          },

          ----- Remappings
          -- Resize windows
          ["<M-Up>"] = opts.mappings.n["<C-Up>"],
          ["<M-Down>"] = opts.mappings.n["<C-Down>"],
          ["<M-Left>"] = opts.mappings.n["<C-Left>"],
          ["<M-Right>"] = opts.mappings.n["<C-Right>"],
          -- Format
          ["<M-f>"] = {
            function() vim.lsp.buf.format(require("astrolsp").format_opts) end,
            desc = "Format buffer",
          },
          -- ["<M-f>"] = { function() require("conform").format { async = true } end, desc = "Format buffer" },
        },
        v = {
          -- Move lines up/down
          ["<M-k>"] = { "<cmd>'<,'>m '<-2<cr>gv", desc = "Move lines up" },
          ["<M-j>"] = { "<cmd>'<,'>m '>+1<cr>gv", desc = "Move lines down" },

          ----- Remappings
          -- Format
          ["<M-f>"] = {
            function() vim.lsp.buf.format(require("astrolsp").format_opts) end,
            desc = "Format buffer",
          },
          -- ["<M-f>"] = { function() require("conform").format { async = true } end, desc = "Format buffer" },
        },
        i = {
          ----- Remappings
          -- Format
          ["<M-f>"] = {
            function() vim.lsp.buf.format(require("astrolsp").format_opts) end,
            desc = "Format buffer",
          },
          -- ["<M-f>"] = { function() require("conform").format { async = true } end, desc = "Format buffer" },
        },
      },
    }

    return vim.tbl_deep_extend("force", opts, local_opts)
  end,
}
