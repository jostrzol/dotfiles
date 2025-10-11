---@type LazyPluginSpec
return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  specs = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>fS"] = { '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
          ["<Leader>fsw"] = {
            '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
            desc = "Search current word",
          },
          ["<leader>fsw"] = { '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word" },
          ["<Leader>fsp"] = {
            '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
            desc = "Search on current file",
          },
        },
      },
    },
  },
}
