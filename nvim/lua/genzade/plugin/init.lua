local M = {}
local fn = vim.fn
local packer_bootstrap

M.ensure_packer = function()
  local install_path = DATA_PATH ..
                         "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system {
      "git",
      "clone",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    }
    vim.cmd [[packadd packer.nvim]]
  end
end

M.plugin_modules = function()
  local plug_dir =
    fn.stdpath("config") .. "/lua/" .. "genzade" .. "/plugins"

  return fn.readdir(plug_dir)
end

M.packer_setup = function()
  local ok, packer = pcall(require, "packer")
  if not ok then
    print("packer not ok .....................................")
    return
  end

  packer.startup(
    {
      function(use)
        use("wbthomason/packer.nvim")

        for _, module in ipairs(M.plugin_modules()) do
          use(
            require(
              "genzade" .. "." .. "plugins" .. "." .. module
            )
          )
        end

        if packer_bootstrap then
          packer.sync()
        end
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