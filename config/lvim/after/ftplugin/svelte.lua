lvim.keys.normal_mode["<M-f>"] = "<Cmd>lua require('lvim.lsp.utils').format()<CR>"
vim.keymap.set("n", "<M-o>",
  function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = {
          "source.organizeImports",
          "source.sortImports",
        }
      }
    })
  end,
  { silent = true, noremap = true, desc = "Organize imports" }
)
