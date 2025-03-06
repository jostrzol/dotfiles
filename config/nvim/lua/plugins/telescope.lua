---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        ---@type AstroCoreOpts
        local opts_local = {
          mappings = {
            n = {
              -- Find diagnostics
              ["<Leader>fd"] = opts.mappings.n["<Leader>lD"],
            },
          },
        }

        return vim.tbl_deep_extend("force", opts, opts_local)
      end,
    },
  },
}
