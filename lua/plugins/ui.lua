vim.cmd("colorscheme tokyonight")

local ok_starter, starter = pcall(require, "mini.starter")
if ok_starter then
  local logo = table.concat({
    [[  _   __               _         ]],
    [[ / | / /__  ____ _   _(_)___ ___ ]],
    [[/  |/ / _ \/ __ \ | / / / __ `__ \]],
    [[/ /|  /  __/ /_/ / |/ / / / / / / /]],
    [[/_/ |_/\___/\____/|___/_/_/ /_/ /_/ ]],
  }, "\n")
  starter.setup({
    evaluate_single = true,
    header = logo,
    items = {
      { name = "Find file", action = "Telescope find_files", section = "Telescope" },
      { name = "Recent files", action = "Telescope oldfiles", section = "Telescope" },
      { name = "Grep text", action = "Telescope live_grep", section = "Telescope" },
      { name = "LazyGit", action = "lua require('snacks').lazygit()", section = "Tools" },
      { name = "Mason", action = "Mason", section = "Tools" },
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
    options = { theme = "tokyonight" },
    sections = {
      lualine_x = { function() return "😄" end, "encoding", "fileformat", "filetype" }
    }
  })
end
