local M = {}

function _G.put(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

---@param mappings AstroLSPMappings
---@param prefix_a string
---@param prefix_b string
M.swap_mapping_deep = function(mappings, prefix_a, prefix_b)
  local normal_maps = mappings.n or {}

  -- Collect mappings to swap
  local maps_a = {}
  local maps_b = {}

  for lhs, map in pairs(normal_maps) do
    if vim.startswith(lhs, prefix_a) then
      maps_a[lhs] = map
    elseif vim.startswith(lhs, prefix_b) then
      maps_b[lhs] = map
    end
  end

  ---@param lhs string
  ---@param old_prefix string
  ---@param new_prefix string
  local function replace_prefix(lhs, old_prefix, new_prefix)
    local suffix = lhs:sub(#old_prefix + 1)
    return new_prefix .. suffix
  end

  -- Unmap old bindings
  for lhs, _ in pairs(maps_a) do
    normal_maps[lhs] = nil
  end
  for lhs, _ in pairs(maps_b) do
    normal_maps[lhs] = nil
  end

  -- Map new bindings
  for lhs, map in pairs(maps_a) do
    local new_lhs = replace_prefix(lhs, prefix_a, prefix_b)
    normal_maps[new_lhs] = map
  end
  for lhs, map in pairs(maps_b) do
    local new_lhs = replace_prefix(lhs, prefix_b, prefix_a)
    normal_maps[new_lhs] = map
  end

  -- -- Re-map with swapped prefixes
  -- for _, map in ipairs(maps_a) do
  --   local new_lhs = leader .. "T" .. suffix(map.lhs)
  --   vim.keymap.set(
  --     "n",
  --     new_lhs,
  --     map.rhs or map.callback,
  --     { desc = map.desc, noremap = not map.remap, silent = map.silent }
  --   )
  -- end
  --
  -- for _, map in ipairs(maps_b) do
  --   local new_lhs = leader .. "t" .. suffix(map.lhs)
  --   vim.keymap.set(
  --     "n",
  --     new_lhs,
  --     map.rhs or map.callback,
  --     { desc = map.desc, noremap = not map.remap, silent = map.silent }
  --   )
  -- end
  --
  -- vim.notify("Swapped <leader>t and <leader>T keymaps.", vim.log.levels.INFO)
end

return M
