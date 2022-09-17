local config = function()
  local map = vim.keymap.set

  map("n", "<TAB>", "<CMD>BufferNext<CR>")
  map("n", "<S-TAB>", "<CMD>BufferPrevious<CR>")
  map("n", "<A-x>", "<CMD>BufferClose<CR>")

  local ok, bufferline_state = pcall(require, "bufferline.state")
  if not ok then
    print("bufferline_state not ok ...........................")
    return
  end

  vim.api.nvim_create_autocmd(
    "BufWinEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "NvimTree" then
          bufferline_state.set_offset(FILETREE_WIDTH, "FileTree")
        end
      end,
    }
  )

  vim.api.nvim_create_autocmd(
    "BufWinLeave", {
      pattern = "*",
      callback = function()
        if vim.fn.expand("<afile>"):match("NvimTree") then
          bufferline_state.set_offset(0)
        end
      end,
    }
  )
end

return {
  "romgrk/barbar.nvim",
  requires = { "kyazdani42/nvim-web-devicons" },
  event = "BufAdd",
  config = config,
}
