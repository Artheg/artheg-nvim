return {
  startup = function (use)
    --
    --
    --

    cfg = {
      debug = false, -- set to true to enable debug logging
      log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
      -- default is  ~/.cache/nvim/lsp_signature.log
      verbose = false, -- show debug line number

      bind = true, -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to falselua
      doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default

      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap

      floating_window_off_x = 1, -- adjust float windows x position.
      floating_window_off_y = 1, -- adjust float windows y position.


      fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ",  -- Panda for parameter
      hint_scheme = "String",
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
      -- to view the hiding contents
      max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "rounded"   -- double, rounded, single, shadow, none
      },

      always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

      auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
      extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

      padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

      transparency = nil, -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 36, -- if you using shadow as border use this set the opacity
      shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    }

    -- lsp signature
    use 'ray-x/lsp_signature.nvim'
    -- recommended:
    require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key
    --
    -- fast search 
    -- use { 'camspiers/snap' }
    -- local snap = require'snap'
    -- snap.maps {
    --   {"<Leader><Leader>", snap.config.file {producer = "fd.file"}},
    --   {"<Leader>fb", snap.config.file {producer = "vim.buffer"}},
    --   {"<Leader>fo", snap.config.file {producer = "vim.oldfile"}},
    --   {"<Leader>ff", snap.config.vimgrep {}},
    -- }


    -- symbols outline
    use 'simrat39/symbols-outline.nvim'


    -- Neovim LSP Integration
    use 'neovim/nvim-lspconfig'
    use 'gfanto/fzf-lsp.nvim'

    -- lsp saga
    use { 'tami5/lspsaga.nvim' }  -- nightly

    -- colors for lsp diagnostics events (warning, error, etc.)
    use 'folke/lsp-colors.nvim'
    local has_lsp_colors,lsp_colors = pcall(require, 'lsp-colors')
    if has_lsp_colors then
      lsp_colors.setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
      })
    end

    -- coq_nvim autocompletion
    use {'ms-jpq/coq_nvim', branch='coq', run=':COQdeps' }
    vim.g.coq_settings = { 
      auto_start='shut-up',
      limits = { completion_auto_timeout = 1.00 },
      keymap = { manual_complete="<c-i>", recommended = false }, 
    }

  use 'windwp/nvim-autopairs'
  local has_npairs,npairs = pcall(require, 'nvim-autopairs')
  if has_npairs then
    npairs.setup({ map_bs = false, map_cr = false })
  end

local remap = vim.api.nvim_set_keymap

npairs.setup({ map_bs = false, map_cr = false })
local Rule   = require'nvim-autopairs.rule'

npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
    -- lots of snippets from ms-jpg
    -- use {'ms-jpq/coq.artifacts', branch='artifacts' }

    ----- Typescript

    -- highlighter
    use 'leafgarland/typescript-vim'

    local has_nvim_lsp,nvim_lsp = pcall(require, "lspconfig")
    local format_async = function(err, _, result, _, bufnr)
      if err ~= nil or result == nil then return end
      if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
          vim.api.nvim_command("noautocmd :update")
        end
      end
    end
    -- vim.lsp.handlers["textDocument/formatting"] = format_async
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
      vim.cmd("command! LspOrganize lua lsp_organize_imports()")
      vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
      vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
      vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
      vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
      vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
      vim.cmd(
      "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
      vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
      buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
      buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
      buf_map(bufnr, "n", "gR", ":References<CR>", {silent = true})
      buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
      buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
      buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
      buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", {silent = true})
      buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", {silent = true})
      buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
      buf_map(bufnr, "v", "ga", ":RangeCodeActions<CR>", {silent = true})
      buf_map(bufnr, "n", "gf", ":LspFormatting<CR>", {silent = true})
      buf_map(bufnr, "n", "<Leader>a", ":Diagnostics<CR>", {silent = true})
      buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
      {silent = true})
      -- if client.resolved_capabilities.document_formatting then
      --   vim.api.nvim_exec([[
      --   augroup LspAutocommands
      --   autocmd! * <buffer>
      --   autocmd BufWritePost <buffer> LspFormatting
      --   augroup END
      --   ]], true)
      -- end
    end
    if has_nvim_lsp then
      nvim_lsp.tsserver.setup {
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          on_attach(client, bufnr)
        end
      }
      nvim_lsp.eslint.setup{}

    end
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
    if has_nvim_lsp then
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
    end
    -----

    -- HTML
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    if has_nvim_lsp then
      nvim_lsp.html.setup {
        capabilities = capabilities,
      }
    end

    -- Angular
    -- local project_library_path = "/usr/lib/node_modules"
    -- local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

    -- nvim_lsp.angularls.setup{
    --   cmd = cmd,
    --   on_attach = on_attach,
    --   on_new_config = function(new_config,new_root_dir)
    --     new_config.cmd = cmd
    --   end,
    -- }

    nvim_lsp.zls.setup {
      on_attach = on_attach
    }

    if has_nvim_lsp then
      nvim_lsp.cmake.setup{
        on_attach = on_attach
      }

      nvim_lsp.ccls.setup {
        on_attach = on_attach,
        init_options = {
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
    end

    -- icons for lsp
    -- https://github.com/folke/trouble.nvim/issues/52#issuecomment-863885779
    local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
    for type, icon in pairs(signs) do
      local hl = "LspDiagnosticsSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end
}
