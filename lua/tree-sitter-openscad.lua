local M = {}

function M.register_parser()
  local parsers = require("nvim-treesitter.parsers")

  -- Register the plugin path as a tree-sitter parser to nvim-treesitter.
  -- This is not required, but it allows nvim-treesitter to manage it e.g. :TS{Install,Update} openscad
  local file = debug.getinfo(1).source:match("@(.*/)")
  local plugin_dir = vim.fn.fnamemodify(file, ":p:h:h")

  --- @type ParserInfo[]
  local parser_config

  if type(parsers.get_parser_configs) == "function" then
    parser_config = parsers.get_parser_configs()
  else
    -- "nvim-treesitter.parsers" exports the parser table itself starting nvim-treesitter v1.x
    parser_config = parsers
  end

  parser_config.jinja2 = {
    install_info = {
      url = plugin_dir,
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = "scad",
  }
end

function M.init()
  M.register_parser()

  vim.treesitter.language.add("openscad", {
    path = vim.api.nvim_get_runtime_file("parser/openscad.so", false)[1],
    symbol_name = "openscad",
  })

  vim.filetype.add({
    extension = {
      scad = "openscad",
    },
    pattern = {
      [".*%.scad"] = "openscad",
    },
  })
end

return M
