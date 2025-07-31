---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local astro = require "astrocore"

        -- stolen from autocore/plugins/toggleterm.lua
        ---@param extra_flags string?
        local callback = function(extra_flags)
          local worktree = astro.file_worktree()
          local worktree_flags = worktree
              and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
            or ""
          local flags = worktree_flags .. " " .. (extra_flags or "")

          astro.toggle_term_cmd { cmd = "lazygit " .. flags, direction = "tab" }
        end

        ---@type AstroCoreOpts
        local opts_local = {
          mappings = {
            n = {
              ["<Leader>gg"] = { callback, desc = "LazyGit" },
              ["<Leader>tl"] = { callback, desc = "LazyGit" },

              ["<Leader>gf"] = {
                function()
                  local path = vim.fn.expand "%:p:~:.:h"
                  callback("--filter " .. path)
                end,
                desc = "LazyGit (file)",
              },
            },
          },
        }

        return vim.tbl_deep_extend("force", opts, opts_local)
      end,
    },
  },
}
