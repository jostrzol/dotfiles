-- Navigation
lvim.keys.normal_mode["]c"] = "<Cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<CR>"
lvim.keys.normal_mode["[c"] = "<Cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<CR>"
lvim.keys.normal_mode["]g"] = "<Cmd>lua vim.diagnostic.goto_next()<CR>"
lvim.keys.normal_mode["[g"] = "<Cmd>lua vim.diagnostic.goto_prev()<CR>"

-- LSP
lvim.lsp.buffer_mappings.normal_mode = {
  K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
  gD = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
  gy = { "<cmd>lua vim.lsp.buf.typeDefinition()<cr>", "Goto type definition" },
  gi = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto implementation" },
  gd = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition" },
  gl = lvim.lsp.buffer_mappings.normal_mode["gl"],
  gu = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto references (usages)" },
  ga = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help" },
  ["<C-.>"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
  ["<space>rn"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
}

-- DAP
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

-- Telescope
lvim.builtin.which_key.mappings["sgb"] = lvim.builtin.which_key.mappings["sb"]
lvim.builtin.which_key.mappings["sb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Buffers" }
lvim.builtin.telescope.defaults.mappings.i["<C-d>"] = require('telescope.actions').delete_buffer
lvim.builtin.telescope.defaults.mappings.n["<C-d>"] = require('telescope.actions').delete_buffer
lvim.builtin.telescope.defaults.mappings.n["q"] = require('telescope.actions').close
lvim.builtin.telescope.pickers.buffers.initial_mode = "insert"

-- Others (which-key)
lvim.builtin.which_key.mappings["bo"] = { "<cmd>BufferLineCloseOthers<cr>", "Close others" }
lvim.builtin.which_key.mappings["bd"] = { "<cmd>bp | bd #<cr>", "Close buffer" }
lvim.builtin.which_key.mappings["bp"] = { "<cmd>BufferLinePick<cr>", "Pick" }
lvim.builtin.which_key.mappings["o"] = { "<cmd>URLOpenUnderCursor<cr>", "Open URL" }

-- Others (non-which-key)
lvim.keys.normal_mode["<C-M-l>"] = "<cmd>:bn<cr>"
lvim.keys.normal_mode["<C-M-h>"] = "<cmd>:bp<cr>"
lvim.keys.normal_mode["<C-M-S-l>"] = "<cmd>:BufferLineMoveNext<cr>"
lvim.keys.normal_mode["<C-M-S-h>"] = "<cmd>:BufferLineMovePrev<cr>"
lvim.keys.normal_mode["<M-Right>"] = "<cmd>:vertical resize +2<cr>"
lvim.keys.normal_mode["<M-Left>"] = "<cmd>:vertical resize -2<cr>"
lvim.keys.normal_mode["<M-Down>"] = "<cmd>:resize +2<cr>"
lvim.keys.normal_mode["<M-Up>"] = "<cmd>:resize -2<cr>"
lvim.keys.normal_mode["<M-f>"] = "<Cmd>lua require('lvim.lsp.utils').format()<CR>"
lvim.keys.normal_mode["<Leader><Leader>"] = "<C-6>"
-- See `https://github.com/LunarVim/LunarVim/discussions/2725#discussioncomment-3131783`
vim.keymap.set(
  { "i" }, "<C-S-Space>",
  function() require("lsp_signature").toggle_float_win() end,
  { silent = true, noremap = true, desc = "Toggle signature" }
)
lvim.keys.normal_mode["<M-m>"] = "<cmd>:make<cr>"
