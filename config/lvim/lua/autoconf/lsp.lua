vim.lsp.set_log_level('debug')

-- remove automatic lsp servers
vim.list_extend(
  lvim.lsp.automatic_configuration.skipped_servers,
  { "rust_analyzer", "pyright", "harper_ls" }
)
-- add automatic lsp servers
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(
  function(server)
    return server ~= "basedpyright"
  end,
  lvim.lsp.automatic_configuration.skipped_servers
)

require("lvim.lsp.manager").setup("marksman")
require("lvim.lsp.manager").setup(
  "harper_ls",
  {
    settings = {
      ["harper-ls"] = {
        linters = {
          -- spell_check = true,
          -- spelled_numbers = false,
          -- an_a = true,
          sentence_capitalization = false,
          -- unclosed_quotes = true,
          -- wrong_quotes = false,
          -- long_sentences = true,
          -- repeated_words = true,
          -- spaces = true,
          -- matcher = true,
          -- correct_number_suffix = true,
          -- number_suffix_capitalization = true,
          -- multiple_sequential_pronouns = true,
          -- linking_verbs = false,
          -- avoid_curses = true,
          -- terminating_conjunctions = true
        }
      }
    },
  }
)

vim.list_extend(lvim.builtin.cmp.sources, { name = "cmp_nvim_r", priority_weight = 110 })
