return {
  "kyazdani42/nvim-tree.lua",
  requires = {
    "kyazdani42/nvim-web-devicons",
    opt = true,
  },
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFileToggle" },
  event = "BufEnter",
  config = function()
    local ok, nvim_tree = pcall(require, "nvim-tree")

    if not ok then
      -- replace with notify
      print("nvim tree not ok ..................................")
      return
    end

    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    map("n", "<Leader>e", "<CMD>NvimTreeFindFileToggle<CR>", opts)

    nvim_tree.setup(
      {
        view = {
          width = 50,
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
  end,
}
