local config = function()
  local has_telescope, telescope = pcall(require, "telescope")
  if not has_telescope then
    print("telescope not ok ..................................")
    return
  end
  telescope.setup {
    defaults = {
      prompt_prefix = "$ ",
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        -- case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  }
  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  telescope.load_extension("fzf")

  local map = vim.keymap.set

  local has_tbuiltin, tbuiltin = pcall(require, "telescope.builtin")
  if not has_tbuiltin then
    print("telescope builtin not ok ...........................")
    return
  end

  map("n", "<Leader>fC", tbuiltin.command_history)
  map("n", "<Leader>fb", tbuiltin.buffers)
  map("n", "<Leader>ff", tbuiltin.find_files)
  map("n", "<Leader>fg", tbuiltin.git_files)
  map("n", "<Leader>fh", tbuiltin.help_tags)
  map("n", "<Leader>fl", tbuiltin.live_grep)
  map("n", "<Leader>fr", tbuiltin.registers)
  map("n", "<Leader>fs", tbuiltin.grep_string)

  map(
    "x", "<Leader>fs", function()
      local visual_selection = function()
        -- Get visually selected text
        vim.cmd("noau normal! \"vy\"")

        local text = vim.fn.getreg("v")

        vim.fn.setreg("v", {})

        text = string.gsub(text, "\n", "")

        if string.len(text) == 0 then
          text = nil
        end

        return text
      end

      tbuiltin.grep_string({ search = visual_selection() })
    end
  )

  map(
    "n", "<Leader>fc", function()
      local ok, telescope_theme = pcall(require, "telescope.themes")
      if not ok then
        return
      end

      tbuiltin.current_buffer_fuzzy_find(telescope_theme.get_ivy())
    end
  )
end

return {
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  },
  event = "VimEnter",
  config = config,
}
