if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "astrodark",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
    -- Configure status line components
    status = {
      -- Add texlab build status component
      component = {
        texlab_build_status = function()
          local clients = vim.lsp.get_clients({ name = "texlab" })
          if #clients == 0 or vim.bo.filetype ~= "tex" then
            return ""
          end
          
          -- Check if build is in progress by looking for latexmk process
          local handle = io.popen("pgrep -f latexmk")
          local result = handle:read("*a")
          handle:close()
          
          if result and result ~= "" then
            return "📄 Building..."
          else
            return ""
          end
        end,
      },
      -- Configure where the component appears in the status line
      opts = {
        statusline = {
          -- Insert the texlab build status after the diagnostics component
          {
            static = {
              texlab_status = function(self)
                return require("astroui.status").component.texlab_build_status()
              end,
            },
            {
              provider = function(self) return self.texlab_status() end,
              condition = function() return vim.bo.filetype == "tex" end,
              hl = { fg = "yellow" },
              { provider = " " }, -- spacing
            },
          },
        },
      },
    },
  },
}
