local config = function()
  local projections = require("genzade.plugins.projectionist.projections")
  -- have a look at https://github.com/veezus/clean-living/blob/24a4271a6c/.projections.json
  vim.g.projectionist_heuristics = {
    -- Rails
    ["Gemfile&config/boot.rb&config/application.rb"] = projections.ruby_on_rails,
    -- Generic ruby project
    ["Gemfile&!config/boot.rb&!spec/rails_helper.rb"] = projections.ruby_generic,
  }

  local map = vim.api.nvim_set_keymap
  local opts = { silent = true }

  map("n", "<leader>aa", [[:A<CR>]], opts)
  map("n", "<leader>av", [[:AV<CR>]], opts)
  map("n", "<leader>as", [[:AS<CR>]], opts)
  map("n", "<leader>at", [[:AT<CR>]], opts)
end

return { "tpope/vim-projectionist", config = config }
