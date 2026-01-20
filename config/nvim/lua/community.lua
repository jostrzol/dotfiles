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
  { import = "astrocommunity.pack.cs" },
  { import = "astrocommunity.pack.typst" },
  { import = "astrocommunity.pack.dart" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.test.neotest" },
  -- { import = "astrocommunity.code-runner.molten-nvim" },
  { import = "astrocommunity.pack.quarto" },
  -- import/override with your plugins folder
  { import = "astrocommunity.keybinding.hydra-nvim" },
}
