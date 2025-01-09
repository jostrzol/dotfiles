vim.wo.wrap = true
vim.wo.linebreak = true
vim.opt.clipboard = "unnamed"
vim.opt.spelllang = "en,pl"

-- fix nvim spellfile.vim plugin, which creates files under
-- XDG_DATE_HOME/site, but looks for it under XDG_DATA_HOME :/
vim.cmd(":set runtimepath+=" .. vim.fn.stdpath("data") .. "/site")

lvim.builtin.project.manual_mode = true -- don't cd randomly on file open
