-- 1. Core Options
require("config.options")

-- 2. Download and activate plugins
require("config.plugins")

-- 3. Configure plugins by domain
require("plugins.ui")
require("plugins.editor")
require("plugins.lsp")

-- 4. Load keymaps & autocmds last
require("config.keymaps")
require("config.autocmds")
