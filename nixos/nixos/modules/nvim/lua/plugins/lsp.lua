local lsp = require("lsp-zero")
local cmp = require('cmp')
-- local lspconfig = require('lspconfig')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_action = require("lsp-zero").cmp_action()
local cmp_format = require("lsp-zero").cmp_format({details = true})

--lsp.preset("recommended")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("heex", {"html", "elixir"})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {"elixirls"},
  handlers = {
    lsp.default_setup,
  }
})

-- lspconfig.elixirls.setup{cmd = {'/home/dawgora/projects/elixir-ls/release/language_server.sh'};}

vim.lsp.config('elixirls', {cmd = {'/home/dawgora/projects/elixir-ls/release/language_server.sh'};})

cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end
    }),
    sources = {
        {name = 'nvim_lsp'}, 
        {name = 'luasnip'},
        {name = 'buffer'},
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    formatting = cmp_format,
    autocmoplete = true
  })

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = ''
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'gi', function()  vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

--lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
  },
})
