local M = {}

M.setup = function()
  local modules = { "autocmds", "globals", "keymaps", "settings" }

  for _, module in ipairs(modules) do
    local ok, err = pcall(require, "core" .. "." .. module)
    if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
    end
  end
end

return M
