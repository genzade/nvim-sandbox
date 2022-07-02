local M = {}

M.ensure_packer = function()
  local fn = vim.fn
  local install_path = DATA_PATH ..
                         "/site/pack/packer/start/packer.nvim"
  local execute = vim.api.nvim_command

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system(
      {
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
    )
    execute("packadd packer.nvim")
  end
end

M.packer_setup = function()
  require("packer").startup(
    {
      function(use)
        use("wbthomason/packer.nvim")
      end,
      config = {
        display = {
          open_fn = function()
            return require("packer.util").float({ border = "single" })
          end,
        },
      },
    }
  )
end

M.setup = function()
  M.ensure_packer()
  M.packer_setup()
end

return M
