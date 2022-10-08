local config = function()
  local set_hl = vim.api.nvim_set_hl
  local has_gitsigns, gitsigns = pcall(require, "gitsigns")
  if not has_gitsigns then
    return
  end

  set_hl(0, "SignColumn", { fg = "NONE", bg = "NONE" })
  set_hl(0, "GitSignsAdd", { fg = "Green", bg = "NONE" })
  set_hl(0, "GitSignsChange", { fg = "Yellow", bg = "NONE" })
  set_hl(0, "GitSignsDelete", { fg = "Red", bg = "NONE" })
  set_hl(0, "VertSplit", { fg = "NONE", bg = "NONE" })

  gitsigns.setup(
    {
      signs = {
        add = {
          hl = "GitSignsAdd",
          text = "+",
          numhl = "GitSignsAddNr",
          linehl = "GitSignsAddLn",
        },
        change = {
          hl = "GitSignsChange",
          text = "│",
          -- text = "│ ",
          -- text = "▎",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        --   delete = {
        --     hl = "GitSignsDelete",
        --     text = "_",
        --     numhl = "GitSignsDeleteNr",
        --     linehl = "GitSignsDeleteLn",
        --   },
        --   topdelete = {
        --     hl = "GitSignsDelete",
        --     text = "‾",
        --     numhl = "GitSignsDeleteNr",
        --     linehl = "GitSignsDeleteLn",
        --   },
        changedelete = {
          hl = "GitSignsChange",
          text = "-",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map(
          "n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end

            vim.schedule(
              function()
                gs.next_hunk()
              end
            )

            return "<Ignore>"
          end, { expr = true }
        )

        map(
          "n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end

            vim.schedule(
              function()
                gs.prev_hunk()
              end
            )

            return "<Ignore>"
          end, { expr = true }
        )

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hS", gs.stage_buffer)
        map(
          "n", "<leader>hb", function()
            gs.blame_line { full = true }
          end
        )
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map(
          "n", "<leader>hD", function()
            gs.diffthis("~")
          end
        )
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,

      -- watch_index = { interval = 1000 },
      current_line_blame = true,
      -- sign_priority = 6,
      -- update_debounce = 100,
      -- status_formatter = nil, -- Use default
      -- use_decoration_api = true,
      -- use_internal_diff = true, -- If luajit is present
    }
  )
end

return {
  "lewis6991/gitsigns.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  event = "BufRead",
  config = config,
}
