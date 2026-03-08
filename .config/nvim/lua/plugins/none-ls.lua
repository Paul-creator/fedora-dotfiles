return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        -- add sources here if you use them
        -- sources = { null_ls.builtins.formatting.stylua, ... },
      })
    end,
  },
}
