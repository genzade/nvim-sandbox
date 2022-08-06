local config = function()
  local ok, lualine = pcall(require, "lualine")
  if not ok then
    print("lualine not ok ...........................")
    return
  end
  -- Lualine config
  lualine.setup(
    {
      options = { theme = "onedark" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  )
end

return {
  -- Status line
  "hoob3rt/lualine.nvim",
  requires = { "kyazdani42/nvim-web-devicons", opt = true },
  config = config,
}
