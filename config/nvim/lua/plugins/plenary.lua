---@type LazyPluginSpec
return {
  "nvim-lua/plenary.nvim",
  specs = {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        plenary_filetypes = {
          {
            event = "User",
            pattern = "LazyLoad",
            group = "plenary_filetypes",
            desc = "Add plenary filetypes",
            callback = function(args)
              if args.data ~= "plenary.nvim" then return end

              require("plenary").filetype.add_table {
                extension = {
                  py = "python",
                },
              }
            end,
          },
        },
      },
    },
  },
}
