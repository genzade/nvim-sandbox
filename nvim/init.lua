local modules = { "core", "plugin" }

for _, module in ipairs(modules) do
  require("genzade" .. "." .. module).setup()
end
