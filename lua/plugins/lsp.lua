pcall(function() require("mason").setup() end)

pcall(function()
  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  })
end)

-- LSP Config
local ok_lsp, _lspconfig = pcall(require, "lspconfig")
if ok_lsp then
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if pcall(require, "cmp_nvim_lsp") then
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  end

  vim.lsp.config('*', { capabilities = capabilities })
  vim.lsp.enable('pyright')
  vim.lsp.enable('ts_ls')

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.name == "ts_ls" then
        vim.keymap.set("n", "<leader>co", function()
          vim.lsp.buf.execute_command({ 
              command = "_typescript.organizeImports",
              arguments = { vim.api.nvim_buf_get_name(0) } 
            })
        end, { buffer = args.buf, desc = "Organize Imports" })
      end

      -- NEW: Override Neovim's default mappings to use Telescope's floating menus
      local tel_builtin = require("telescope.builtin")
      vim.keymap.set("n", "gd", tel_builtin.lsp_definitions, { buffer = args.buf, desc = "Go to Definition" })
      vim.keymap.set("n", "gr", tel_builtin.lsp_references, { buffer = args.buf, desc = "Go to References" })
      vim.keymap.set("n", "gI", tel_builtin.lsp_implementations, { buffer = args.buf, desc = "Go to Implementation" })
      
      -- NEW: Friendly `<leader>` mappings (aliases to the built-in `gra` and `grn` defaults)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "Code Action" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "Rename Symbol" })
    end,
  })
end

-- Snippets
pcall(function() require("luasnip.loaders.from_vscode").lazy_load() end)

-- Nvim-cmp
local ok_cmp, cmp = pcall(require, "cmp")
if ok_cmp then
  local luasnip_ok, luasnip = pcall(require, "luasnip")
  
  cmp.setup({
    snippet = {
      expand = function(args)
        if luasnip_ok then luasnip.lsp_expand(args.body) end
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip_ok and luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip_ok and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = "lazydev", group_index = 0 },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
      { name = "emoji" },
    }),
  })
  cmp.setup.cmdline({ '/', '?' }, { 
    mapping = cmp.mapping.preset.cmdline(), 
    sources = { { name = 'buffer' } } 
  })

  cmp.setup.cmdline(':', { 
    mapping = cmp.mapping.preset.cmdline(), 
    sources = cmp.config.sources(
      { { name = 'path' } }, 
      { { name = 'cmdline' } }) 
    })
end
