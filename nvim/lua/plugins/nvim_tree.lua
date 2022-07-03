return {
  "kyazdani42/nvim-tree.lua",
  requires = {
    "kyazdani42/nvim-web-devicons", -- optional, for file icon
    opt = true,
  },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  config = function()
    local ok, nvim_tree = pcall(require, "nvim-tree")

    if not ok then
      -- replace with notify
      print("nvim tree not ok ..................................")
      return
    end

    nvim_tree.setup()
  end,

}
