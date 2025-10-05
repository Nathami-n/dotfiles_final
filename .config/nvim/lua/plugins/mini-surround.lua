return {
  {
    "nvim-mini/mini.nvim",
    version = false,

    config = function()
      local mini = require("mini.surround")

      mini.setup({
        mappings = {
          add = "gsa",
        },
      })
    end,
  },
}
