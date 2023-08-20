require 'lsp_signature'.setup(cfg)

vim.cmd [[set completeopt=menu,menuone,noselect]]

-- Setup nvim-cmp.
local cmp = require 'cmp'
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
    { name = 'vsnip' },
    { name = 'npm',     keyword_length = 3 },
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

local nvim_lsp = require('lspconfig')

local lsp_organize_imports = function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end
_G.lsp_organize_imports = lsp_organize_imports;
local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  require('lspkind').init()
  local buf_map = vim.api.nvim_buf_set_keymap
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.format({ async = true })")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspOrganize lua lsp_organize_imports()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd(
    "command! LspDiagLine lua vim.diagnostic.open_float()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  buf_map(bufnr, "n", "gd", ":LspDef<CR>", { silent = true })
  buf_map(bufnr, "n", "gR", ":LspRename<CR>", { silent = true })
  buf_map(bufnr, "n", "gr", ":Telescope lsp_references<CR>", { silent = true })
  buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", { silent = true })
  buf_map(bufnr, "n", "K", ":LspHover<CR>", { silent = true })
  buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", { silent = true })
  buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", { silent = true })
  buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", { silent = true })
  buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", { silent = true })
  buf_map(bufnr, "v", "ga", ":RangeCodeActions<CR>", { silent = true })
  buf_map(bufnr, "n", "gf", ":LspFormatting<CR>", { silent = true })
  buf_map(bufnr, 'n', '<Leader>ld', ':LspDiagLine<CR>', { silent = true })
  buf_map(bufnr, "n", "<Leader>a", ":Diagnostics<CR>", { silent = true })
  buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
    { silent = true })
end
--
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
nvim_lsp.java_language_server.setup {
  cmd = { "/Users/artem.shtukert/git/java-language-server/dist/lang_server_mac.sh" }
}
nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach
}
nvim_lsp.gdscript.setup {
  on_attach = on_attach
}
-- nvim_lsp.tsserver.setup {
--   capabilities = capabilities,
--   on_attach = function(client, bufnr)
--     client.server_capabilities.document_formatting = false
--     on_attach(client, bufnr)
--   end
-- }

nvim_lsp.zls.setup {
  on_attach = on_attach,
  cmd = { vim.fn.expand("/home/artheg/git/zig/zls/zig-out/bin/zls") }
}

nvim_lsp.ols.setup {}

nvim_lsp.ccls.setup {
  on_attach = on_attach,
  init_options = {
    single_file_support = true,
    compilationDatabaseDirectory = "build",
    index = {
      threads = 0,
    },
    clang = {
      excludeArgs = { "-frounding-math" },
    },
    single_file_support = true,
  },
}


local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(
    bufnr,
    "textDocument/formatting",
    vim.lsp.util.make_formatting_params({}),
    function(err, res, ctx)
      if err then
        local err_msg = type(err) == "string" and err or err.message
        -- you can modify the log message / level (or ignore it completely)
        vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
        return
      end

      -- don't apply results if buffer is unloaded or has been modified
      if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
        return
      end

      if res then
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("silent noautocmd update")
        end)
      end
    end
  )
end

null_ls.setup({
  -- add your sources / config options here
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettier,
  },
  debug = false,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if vim.bo.filetype == 'typescript' or vim.bo.filetype == 'typescriptreact' then
            local original = "@gsbaltic/telesis/src/modules"
            local replacement = "@telesis"
            vim.api.nvim_command("silent! :%s/" ..
            vim.fn.escape(original, "/") .. "/" .. vim.fn.escape(replacement, "/") .. "/g")
            vim.api.nvim_command("silent! :%s/" ..
            vim.fn.escape('@gsbaltic/telesis/src/engines', "/") .. "/" .. vim.fn.escape(replacement, "/") .. "/g")
          end
          async_formatting(bufnr)
        end,
      })
    end
  end,
})

-- icons for lsp
-- https://github.com/folke/trouble.nvim/issues/52#issuecomment-863885779
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
