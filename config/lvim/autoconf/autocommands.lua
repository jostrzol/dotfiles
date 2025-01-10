vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern = { "*.service" },
    command = "set filetype=systemd",
  }
)
