-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  -- extension = {
  --   foo = "fooscript",
  -- },
  filename = {
    -- ["Foofile"] = "fooscript",
    ["LspCapabilities"] = "lua",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
    [".*%.vscode/launch%.json"] = "jsonc",
  },
}

-- Show NeoTree on startup
-- vim.api.nvim_create_autocmd("VimEnter", { command = "Neotree show" })

-- Lsp
-- vim.lsp.set_log_level "DEBUG"
