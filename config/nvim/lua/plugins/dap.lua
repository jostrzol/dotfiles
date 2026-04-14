-- local dap = require "dap"

---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.expand "$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
            "127.0.0.1",
          },
        },
      }
      require("dap").adapters["pwa-chrome"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.expand "$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
            "127.0.0.1",
          },
        },
        skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
      }

      -- require('dap').set_log_level('TRACE')
    end,
  },
  {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
        default_section = "repl",
      },
      auto_toggle = true,
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>dS"] = {
            function()
              local dap = require "dap"
              local Snacks = require "snacks"

              Snacks.picker.pick {
                source = "dap_sessions",
                finder = function()
                  local sessions = dap.sessions()
                  local current = dap.session()

                  local items = {} ---@type snacks.picker.finder.Item[]
                  for idx, session in pairs(sessions) do
                    local text = session.config.name
                    if current and session.id == current.id then text = text .. " (current)" end

                    ---@type snacks.picker.finder.Item
                    local item = {
                      idx = idx,
                      text = text,
                      session = session,
                    }
                    table.insert(items, item)
                  end

                  return items
                end,
                confirm = function(picker, item)
                  picker:close()
                  if not item then return end

                  dap.set_session(item.session)
                end,
                format = function(item, _) return { { item.text } } end,
                layout = {
                  preview = false,
                  hidden = { "input" },
                  layout = {
                    backdrop = {
                      blend = 40,
                    },
                    width = 0.3,
                    min_width = 80,
                    max_height = 12,
                    box = "vertical",
                    border = "rounded",
                    title = " DAP Sessions ",
                    title_pos = "center",
                    { win = "list", border = "none" },
                  },
                },
              }
            end,
            desc = "Switch session",
          },
        },
      },
    },
  },
}
