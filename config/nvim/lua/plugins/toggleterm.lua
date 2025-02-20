---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      ---@param opts AstroLSPOpts
      opts = function(_, opts)
        local astro = require "astrocore"
        -- stolen from autocore/plugins/toggleterm.lua
        local lazygit = {
          callback = function()
            local worktree = astro.file_worktree()
            local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
            astro.toggle_term_cmd { cmd = "lazygit " .. flags, direction = "tab" }
          end,
          desc = "ToggleTerm lazygit",
        }

        local opts_local = {
          mappings = {
            n = {
              ["<Leader>gg"] = { lazygit.callback, desc = lazygit.desc },
              ["<Leader>tl"] = { lazygit.callback, desc = lazygit.desc },
            },
          },
        }

        return vim.tbl_deep_extend("force", opts, opts_local)
      end,
    },
  },
}
