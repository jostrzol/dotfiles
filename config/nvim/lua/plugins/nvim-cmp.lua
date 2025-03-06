---@type LazyPluginSpec
return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    -- limit max length of abbr and menu
    local old_format = opts.formatting.format
    opts.formatting.format = function(entry, item)
      local result = old_format(entry, item)
      -- if result.abbr ~= nil then result.abbr = string.sub(result.abbr, 1, 20) end
      if result.menu ~= nil then result.menu = string.sub(result.menu, 1, 20) end
      return result
    end
  end,
}
