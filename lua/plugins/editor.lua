vim.g.suda_smart_edit = 1

pcall(function() require("mini.pairs").setup() end)
pcall(function() require("mini.ai").setup() end)
pcall(function() require("mini.surround").setup() end)
pcall(function() require("todo-comments").setup() end)

-- Flash (Fast Navigation)
local ok_flash, flash = pcall(require, "flash")
if ok_flash then
  vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
  vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
end

-- Formatting & Linting
local ok_conform, conform = pcall(require, "conform")
if ok_conform then
  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      python = { "isort", "black" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  })
end

local ok_lint, lint = pcall(require, "lint")
if ok_lint then
  lint.linters_by_ft = {}
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function() pcall(lint.try_lint) end,
  })
end

-- Which-key (Spacebar popup)
pcall(function() 
  require("which-key").setup({
    preset = "helix",
  }) 
end)

-- Trouble (Diagnostics base)
pcall(function() require("trouble").setup() end)

-- Snacks.nvim (Pickers, terminal, lazygit, indent)
pcall(function() 
  require("snacks").setup({
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    terminal = { enabled = true },
    indent = { enabled = true },
  }) 
end)

-- Neo-tree
local ok_neotree, neotree = pcall(require, "neo-tree")
if ok_neotree then
  neotree.setup({
    filesystem = {
      filtered_items = {
        visible = true, show_hidden_count = true, hide_dotfiles = false, hide_gitignored = true,
        never_show = { ".git" },
      },
    }
  })
end

-- Telescope
local ok_telescope, telescope = pcall(require, "telescope")
if ok_telescope then
  telescope.setup({
    defaults = { layout_strategy = "horizontal", layout_config = { prompt_position = "top" }, sorting_strategy = "ascending" },
  })
  vim.keymap.set("n", "<leader>fp", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Plugin/Config File" })
end

-- Treesitter
local ok_treesitter, treesitter = pcall(require, "nvim-treesitter.configs")
if ok_treesitter then
  treesitter.setup({
    ensure_installed = { "bash", "html", "javascript", "json", "lua", "markdown", "python", "regex", "tsx", "typescript", "vim", "yaml" },
    highlight = { enable = true },
  })
end
