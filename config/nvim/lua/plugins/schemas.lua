-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      local new_opts = {
        ---@diagnostic disable: missing-fields
        config = {
          yamlls = {
            settings = {
              yaml = {
                schemas = require("schemastore").yaml.schemas {
                  extra = {
                    {
                      description = "Taskfile",
                      fileMatch = { "taskfile*.yml" },
                      name = "Taskfile",
                      -- -- source: https://taskfile.dev/schema.json
                      url = vim.fn.expand "$HOME/.config/schemas/yaml/taskfile.json",
                    },
                  },
                },
              },
            },
          },
          jsonls = {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas {
                  extra = {
                    {
                      description = "code snippet files in visual studio code extensions",
                      fileMatch = { "**/snippets/*.json" },
                      name = "VSCode Code Snippets (*.json)",
                      url = "https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json",
                    },
                  },
                },
              },
            },
          },
        },
      }

      local result = vim.tbl_deep_extend("force", opts, new_opts)

      return result
    end,
  },
  { "b0o/schemastore.nvim" },
}
