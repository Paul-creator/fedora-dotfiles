-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- go to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })

-- reveal in dolphin (Fedora / KDE)
vim.keymap.set("n", "O", function()
  local picker = vim.tbl_filter(function(p)
    return not p.closed
  end, Snacks.picker.get({ tab = true }))[1]
  if not picker then
    return
  end

  local items = picker:selected({ fallback = true })

  for _, item in ipairs(items) do
    local path = vim.fn.fnamemodify(item.file or item.text, ":p")
    vim.fn.jobstart({ "dolphin", "--select", path }, { detach = true })
  end
end)

-- preview_definition
local function preview_definition()
  local bufnr = vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = "textDocument/definition",
  })

  if vim.tbl_isempty(clients) then
    vim.cmd("normal! K")
    return
  end

  local client = clients[1]
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding or "utf-16")

  client:request("textDocument/definition", params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      vim.schedule(function()
        vim.cmd("normal! K")
      end)
      return
    end

    local location = vim.tbl_islist(result) and result[1] or result

    vim.schedule(function()
      vim.lsp.util.preview_location(location, {
        border = "rounded",
      })
    end)
  end, bufnr)
end

local function is_matlab_function_call()
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col(".")

  local word_start = vim.fn.matchstrpos(line:sub(1, col), [[\k*$]])[2]
  local word = vim.fn.expand("<cword>")

  if word == "" or word_start < 0 then
    return false
  end

  local after_word = line:sub(word_start + #word + 1)
  return after_word:match("^%s*%(") ~= nil
end

local function smart_k()
  local bufnr = vim.api.nvim_get_current_buf()

  local hover_clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = "textDocument/hover",
  })

  if not vim.tbl_isempty(hover_clients) then
    vim.lsp.buf.hover()
    return
  end

  if vim.bo[bufnr].filetype == "matlab" and is_matlab_function_call() then
    vim.cmd("normal! K")
    return
  end

  preview_definition()
end

vim.keymap.set("n", "K", smart_k, {
  desc = "Smart Hover / Docs / Definition Preview",
})
