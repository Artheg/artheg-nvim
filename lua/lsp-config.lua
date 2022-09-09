require'lsp_signature'.setup(cfg)

vim.cmd[[set completeopt=menu,menuone,noselect]]

-- Setup nvim-cmp.
local cmp = require'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on(
'confirm_done',
cmp_autopairs.on_confirm_done()
)
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

local npairs = require('nvim-autopairs')
npairs.setup()

local nvim_lsp = require('lspconfig')

_G.lsp_organize_imports = function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end
_G.fix_issues = function ()
  vim.lsp.buf.execute_command({
    command = '_typescript.organizeImports',
    arguments = {vim.api.nvim_buf_get_name(0)}
  })
  vim.lsp.buf.execute_command({
    command = 'Neoformat',
    arguments = {vim.api.nvim_buf_get_name(0)},
  })
  vim.lsp.buf.execute_command({
    command = 'ALEFix',
    arguments = {vim.api.nvim_buf_get_name(0)},
  })
end
local on_attach = function(client, bufnr)
  local buf_map = vim.api.nvim_buf_set_keymap
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspOrganize lua fix_issues()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd(
  "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
  buf_map(bufnr, "n", "gR", ":Lspsaga rename<CR>", {silent = true})
  buf_map(bufnr, "n", "gr", ":LspRefs<CR>", {silent = true})
  buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
  buf_map(bufnr, "n", "K",  ":Lspsaga hover_doc<CR>", {silent = true})
  buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
  buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", {silent = true})
  buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", {silent = true})
  buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
  buf_map(bufnr, "v", "ga", ":RangeCodeActions<CR>", {silent = true})
  buf_map(bufnr, "n", "gf", ":LspFormatting<CR>", {silent = true})
  buf_map(bufnr, 'n', '<Leader>ld', ':Lspsaga show_line_diagnostics<CR>', { silent = true })
  buf_map(bufnr, "n", "<Leader>a", ":Diagnostics<CR>", {silent = true})
  buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
  {silent = true})
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
nvim_lsp.rust_analyzer.setup{
  on_attach = on_attach
}
require('typescript').setup()
nvim_lsp.gdscript.setup{
  on_attach = on_attach
}
nvim_lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end
}
nvim_lsp.eslint.setup{
  on_attach = on_attach
}

local filetypes = {
  typescript = "eslint",
  typescriptreact = "eslint",
  html = "eslint"
}
local linters = {
  eslint = {
    sourceName = "eslint_d",
    command = "eslint_d",
    rootPatterns = {".eslintrc.json", "package.json"},
    debounce = 100,
    args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
    parseJson = {
      errorsRoot = "[0].messages",
      line = "line",
      column = "column",
      endLine = "endLine",
      endColumn = "endColumn",
      message = "${message} [${ruleId}]",
      security = "severity"
    },
    securities = {[2] = "error", [1] = "warning"}
  }
}
local formatters = {
  prettier = {command = "prettierd", args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)}, rootPatterns = {".eslintrc.json", "package.json"}}
}
local formatFiletypes = {
  typescript = "prettierd",
  typescriptreact = "prettierd"
}
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = vim.tbl_keys(filetypes),
  init_options = {
    filetypes = filetypes,
    linters = linters,
    formatters = formatters,
    formatFiletypes = formatFiletypes
  }
}

nvim_lsp.zls.setup {
  on_attach = on_attach
}


nvim_lsp.ccls.setup {
  on_attach = on_attach,
  init_options = {
    single_file_support = true;
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
    single_file_support = true;
  };
}

-- icons for lsp
-- https://github.com/folke/trouble.nvim/issues/52#issuecomment-863885779
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
