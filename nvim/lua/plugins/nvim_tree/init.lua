local config = function()
  local ok, nvim_tree = pcall(require, "nvim-tree")

  if not ok then
    -- replace with notify
    print("nvim tree not ok ..................................")
    return
  end

  local map = vim.keymap.set

  map("n", "<Leader>e", "<CMD>NvimTreeFindFileToggle<CR>")

  nvim_tree.setup(
    {
      view = {
        width = FILETREE_WIDTH,
        preserve_window_proportions = true,
        mappings = {
          custom_only = false,
          list = {
            -- user mappings go here
          },
        },
      },
    }
  )
end

return {
  "kyazdani42/nvim-tree.lua",
  requires = { "kyazdani42/nvim-web-devicons", opt = true },
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFileToggle" },
  event = "BufEnter",
  config = config,
}
