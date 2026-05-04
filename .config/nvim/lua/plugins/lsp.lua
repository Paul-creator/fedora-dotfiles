-- important mason install vhdl_ls did not work consistently.
-- this doing a manual install using crates.io (cargo) !important
-- vhdl libs must be be pasted into same folder like vhdl_ls
-- https://github.com/VHDL-LS/rust_hdl/tree/master/vhdl_libraries

return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.filetype.add({
        extension = {
          vhd = "vhdl",
          m = "matlab",
        },
      })

      vim.lsp.config("vhdl_ls", {
        cmd = { "/bin/bash", vim.env.HOME .. "/.local/bin/vhdl_ls_wrapper" },
        filetypes = { "vhdl" },
        root_markers = { "vhdl_ls.toml", ".vhdl_ls.toml" },
        single_file_support = false,
      })

      vim.lsp.config("matlab_ls", {
        cmd = {
          vim.fn.stdpath("data") .. "/mason/bin/matlab-language-server",
          "--stdio",
        },

        filetypes = { "matlab" },

        root_dir = function(bufnr, on_dir)
          local root = vim.fs.root(bufnr, { ".git" })
          on_dir(root or vim.fn.getcwd())
        end,

        settings = {
          MATLAB = {
            installPath = "/home/paul/Programs/MATLAB/R2024b",
            indexWorkspace = true,
            matlabConnectionTiming = "onStart",
            telemetry = false,
          },
        },
      })

      vim.lsp.enable({
        "vhdl_ls",
        "matlab_ls",
      })
    end,
  },
}
