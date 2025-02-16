-- Neovim plugin build script
-- See https://github.com/folke/lazy.nvim#-plugin-spec

require("tree-sitter-openscad").register_parser()
vim.cmd("TSInstall! openscad")
