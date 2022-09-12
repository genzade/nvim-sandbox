vim.highlight.create(
  "Comment", { cterm = "italic", gui = "italic" }, false
)

local config = function()
  local ok, kommentary_config = pcall(require, "kommentary.config")
  if not ok then
    return
  end

  kommentary_config.configure_language(
    "default", { prefer_single_line_comments = true }
  )

  kommentary_config.use_extended_mappings()
end

return { "b3nj5m1n/kommentary", config = config }
