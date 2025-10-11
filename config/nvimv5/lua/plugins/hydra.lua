---@type LazySpec
return {
  "nvimtools/hydra.nvim",
  ---@type table<string, hydra.Config>
  opts = {
    ["Next"] = {
      mode = "n",
      body = "]",
      heads = {
        { "s", "]s", { desc = "Next misspelled word" } },
      },
    },
    ["Previous"] = {
      mode = "n",
      body = "[",
      heads = {
        { "s", "[s", { desc = "Previous misspelled word" } },
      },
    },
  },
}
