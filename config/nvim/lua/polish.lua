-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    tex = "tex",
  },
  filename = {
    -- ["Foofile"] = "fooscript",
    ["LspCapabilities"] = "lua",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
    [".*%.vscode/launch%.json"] = "jsonc",
    ["%.env%..*"] = "sh",
  },
}

-- Show NeoTree on startup
-- vim.api.nvim_create_autocmd("VimEnter", { command = "Neotree show" })

-- Lsp
-- vim.lsp.set_log_level "DEBUG"

-- Dap
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
  -- use nvim-dap-vscode-js's pwa-chrome debug adapter
  type = "server",
  request = "launch",
  -- name of the debug action
  name = "Launch Chrome to debug client side code",
  -- default vite dev server url
  url = "http://localhost:5173",
  -- for TypeScript/Svelte
  sourceMaps = true,
  webRoot = "${workspaceFolder}/src",
  protocol = "inspector",
  port = 9222,
  -- skip files from vite's hmr
  skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
}

-- require('dap').set_log_level('TRACE')
