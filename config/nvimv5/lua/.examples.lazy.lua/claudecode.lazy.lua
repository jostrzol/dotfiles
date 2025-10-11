-- Example local configuration that:
-- * makes Claude Code window to appear on bottom

if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazyPluginSpec[]
return {
  {
    "coder/claudecode.nvim",
    ---@type ClaudeCodeConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ---@diagnostic disable-next-line: missing-fields
      terminal = {
        snacks_win_opts = {
          position = "bottom",
          height = 0.4,
          width = 1.0,
          border = "single",
        },
      },
    },
  },
}
