local config = function()
  local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  }

  for sign_type, sign_icon in pairs(signs) do
    local hl = "DiagnosticSign" .. sign_type
    vim.fn.sign_define(
      hl, { text = sign_icon, texthl = hl, numhl = hl }
    )
  end

  local mason_ok, mason = pcall(require, "mason")
  if not mason_ok then
    return
  end

  mason.setup(
    {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }
  )

  local mason_lspc_ok, mason_lspc = pcall(require, "mason-lspconfig")
  if not mason_lspc_ok then
    return
  end

  local servers = {
    "bashls",
    "clangd",
    "cssls",
    "dockerls",
    "html",
    "solargraph",
    "sumneko_lua",
    "tailwindcss",
    "tsserver",
    "yamlls",
  }

  mason_lspc.setup(
    { ensure_installed = servers, automatic_install = true }
  )

  local lspc_ok, lspconfig = pcall(require, "lspconfig")
  if not lspc_ok then
    return
  end

  local on_attach =
    require("genzade.plugins.lspconfig.defaults").on_attach

  -- uncomment to setup enhanced servers
  -- local enhance_server_opts = {
  --   ["sumneko_lua"] = function(opts)
  --     local runtime_path = vim.split(package.path, ";")

  --     table.insert(runtime_path, "lua/?.lua")
  --     table.insert(runtime_path, "lua/?/init.lua")

  --     opts.settings = {
  --       Lua = {
  --         runtime = { version = "LuaJIT", path = runtime_path },
  --         diagnostics = { globals = { "vim" } },
  --         workspace = {
  --           library = vim.api.nvim_get_runtime_file("", true),
  --         },
  --         telemetry = { enable = false },
  --       },
  --     }
  --   end,
  -- }

  local opts = {}
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport =
    true

  local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not cmp_nvim_lsp_ok then
    return
  end

  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  for _, server in ipairs(mason_lspc.get_installed_servers()) do
    opts = { on_attach = on_attach, capabilities = capabilities }

    -- if enhance_server_opts[server.name] then
    --   -- Enhance the default opts with the server-specific ones
    --   enhance_server_opts[server.name](opts)
    -- end

    lspconfig[server].setup(opts)
  end
end

return {
  "neovim/nvim-lspconfig",
  requires = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = config,
}
