local modules = { "core", "plug" }

for _, module in ipairs(modules) do
  require(module).setup()
end
