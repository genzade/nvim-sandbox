local config = function()
  local ok, ts_config = pcall(require, "nvim-treesitter.configs")
  if not ok then
    return
  end

  ts_config.setup(
    {
      -- one of "all" or a list of languages
      -- ensure_installed = "all",
      -- TODO: switch to all post migration
      ensure_installed = {
        "bash",
        "css",
        "html", -- highlight not working on linux
        "javascript",
        "lua",
        "markdown",
        "ruby",
        "scss",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      -- needs testing post migration
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    }
  )
end

return {
  "nvim-treesitter/nvim-treesitter",
  run = function()
    local ok, ts_install = pcall(require, "nvim-treesitter.install")
    if not ok then
      return
    end

    ts_install.update({ with_sync = true })
  end,
  config = config,
}
