
vim.opt.termguicolors = true

-- Ensure it's wrapped in a pcall (safe require) similar to your other plugins
local ok_bluloco, bluloco = pcall(require, "bluloco")
if ok_bluloco then
  bluloco.setup({
    style = "dark",               -- explicitly set to "dark"
    transparent = false,
    italics = false,
    terminal = vim.fn.has("gui_running") == 1, 
    guicursor = true,
    rainbow_headings = false,     
    float_window = "default" 
  })
end

vim.cmd('colorscheme bluloco')
-- vim.cmd("colorscheme tokyonight")

local ok_starter, starter = pcall(require, "mini.starter")
if ok_starter then
  local logo = table.concat({
    [[888b    888                  888     888 d8b              ]],
    [[8888b   888                  888     888 Y8P              ]],
    [[88888b  888                  888     888                  ]],
    [[888Y88b 888  .d88b.   .d88b. Y88b   d88P 888 88888b.d88b. ]],
    [[888 Y88b888 d8P  Y8b d88""88b Y88b d88P  888 888 "888 "88b]],
    [[888  Y88888 88888888 888  888  Y88o88P   888 888  888  888]],
    [[888   Y8888 Y8b.     Y88..88P   Y888P    888 888  888  888]],
    [[888    Y888  "Y8888   "Y88P"     Y8P     888 888  888  888]],
  }, "\n")
  starter.setup({
    evaluate_single = true,
    header = logo,
    items = {
      { name = "Find file", action = "Telescope find_files", section = "Telescope" },
      { name = "Recent files", action = "Telescope oldfiles", section = "Telescope" },
      { name = "Grep text", action = "Telescope live_grep", section = "Telescope" },
      { name = "LazyGit", action = "lua require('snacks').lazygit()", section = "Tools" },
      { name = "File Browser", action = "Neotree toggle", section = "Tools" },
      { name = "Mason", action = "Mason", section = "Tools" },
      { name = "Check Health", action = "checkhealth", section = "Tools" },
      { name = "New file", action = "ene | startinsert", section = "Built-in" },
      { name = "Quit Neovim", action = "qa", section = "Built-in" },
    },
    content_hooks = {
      starter.gen_hook.adding_bullet("░ ", false),
      starter.gen_hook.aligning("center", "center"),
    },
  })
end
pcall(function() require("bufferline").setup() end)
pcall(function() require("gitsigns").setup() end)

local ok_noice, noice = pcall(require, "noice")
if ok_noice then
  noice.setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
  })
end

local ok_lualine, lualine = pcall(require, "lualine")
if ok_lualine then
  lualine.setup({
    options = { theme = "auto" },
    sections = {
      lualine_x = { function() return "😄" end, "encoding", "fileformat", "filetype" }
    }
  })
end
