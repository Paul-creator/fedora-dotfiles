return {
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- Set Skim as the PDF viewer
      vim.g.vimtex_view_method = "skim"
      -- Additional Skim-specific settings for forward/inverse search
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1 -- Skim will auto-focus when you open it
    end,
  },
}
