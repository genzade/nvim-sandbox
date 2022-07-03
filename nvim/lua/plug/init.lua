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

-- local function scandir(directory)
--   local i, t, popen = 0, {}, io.popen
--   local pfile = popen("ls -a \"" .. directory .. "\"")
--   for filename in pfile:lines() do
--     i = i + 1
--     t[i] = filename
--   end
--   pfile:close()
--   return t
-- end

-- local plugin_list = function ()
-- end

M.packer_setup = function()
  require("packer").startup(
    {
      function(use)
        use("wbthomason/packer.nvim")

        for _, file in ipairs(
                         vim.fn.readdir(
                           vim.fn.stdpath("config") .. "/lua/plugins",
                           [[v:val =~ '\.lua$']]
                         )
                       ) do
          use(require("plugins." .. file:gsub("%.lua$", "")))
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
