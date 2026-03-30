return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"

      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_view_general_options = "--synctex-forward @line:@col:@tex @pdf"
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-pdf",
          "-shell-escape",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-file-line-error",
        },
      }

      vim.g.vimtex_quickfix_ignore_filters = {
        "Package fancyhdr Warning",
        "Package fancyhdr Warning: \\\\headheight is too small",
      }

      -- make \vspace{}, \[ \] visible
      vim.g.vimtex_syntax_conceal_disable = 1
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").texlab.setup({
        settings = {
          texlab = {
            build = { onSave = false },
            formatter = "latexindent",
            latexindent = {
              modifyLineBreaks = false,
            },
          },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        tex = { "latexindent" },
        plaintex = { "latexindent" },
        latex = { "latexindent" },
      },
    },
  },
}
