---@module 'claudecode'

---@type LazyPluginSpec
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<Leader>a", nil, desc = "AI/Claude Code" },
    { "<Leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<Leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<Leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<Leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<Leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<Leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<Leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<Leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
    },
    -- Diff management
    { "<Leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<Leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
  specs = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>a"] = { nil, desc = "✻ Claude Code" },
        },
      },
    },
  },
  ---@type ClaudeCodeConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {},
}
