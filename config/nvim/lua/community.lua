-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.svelte" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.kotlin" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.test.neotest" },
  -- import/override with your plugins folder
}
