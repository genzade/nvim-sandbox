local config = function()
  local default_dimmensions = {
    height = 0.9,
    width = 0.9,
    x = 0.5,
    y = 0.5,
  }

  local ok, fterm = pcall(require, "FTerm")
  if not ok then
    print("fterm not ok .....................................")
    return
  end

  fterm.setup(
    {
      dimensions = default_dimmensions,
      border = "single", -- or 'double'
    }
  )

  -- Keybinding
  local map = vim.keymap.set
  local opts = { silent = true }

  -- Closer to the metal
  map({ "n", "t" }, "<C-t>", fterm.toggle, opts)

  -- Commands for FTerm
  map(
    { "n", "t" }, "<C-\\>", function()
      require("FTerm").toggle()
    end
  )

  -- TODO: uncomment when lazygit is installed
  -- -- LazyGit integration
  -- map(
  --   "n", "<Leader>g", function()
  --     local term = require("FTerm.terminal")
  --     local lazygit = term:new()

  --     vim.api.nvim_get_current_buf()
  --     lazygit:setup(
  --       {
  --         dimensions = default_dimmensions,
  --         border = "single", -- or 'double'
  --         cmd = "lazygit",
  --       }
  --     )
  --   end, opts
  -- )

  -- might not be need post migration
  vim.highlight.create(
    "VertSplit", { guibg = "NONE", ctermbg = "NONE" }, false
  )
end

return { "numtostr/FTerm.nvim", config = config }
