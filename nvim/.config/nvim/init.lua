do
  vim.loader.enable()

  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  vim.o.number = true
  vim.o.relativenumber = true

  vim.o.mouse = 'a'

  vim.o.showmode = false

  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  vim.o.breakindent = true
  vim.o.wrap = false

  vim.o.undofile = true

  vim.o.ignorecase = true
  vim.o.smartcase = true

  vim.o.signcolumn = 'yes'

  vim.o.updatetime = 250

  vim.o.timeoutlen = 300

  vim.o.splitright = true
  vim.o.splitbelow = true

  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- vim.o.inccommand = 'split'

  vim.o.cursorline = false

  vim.o.scrolloff = 10

  vim.o.confirm = true
end

do
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    virtual_text = true,
    virtual_lines = false,

    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- vim.api.nvim_create_autocmd('TextYankPost', {
  --   desc = 'Highlight when yanking (copying) text',
  --   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  --   callback = function() vim.hl.on_yank() end,
  -- })
end

do
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---@param repo string
---@return string
-- local function gh(repo) return 'https://github.com/' .. repo end
local gh = function(x) return 'https://github.com/' .. x end

do
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signs = {},
  }

  vim.pack.add { gh 'edeneast/nightfox.nvim' }
  vim.pack.add { gh 'rainglow/vim' }
  vim.pack.add { gh 'harshrajsachan/omni.nvim' }
  vim.pack.add { gh 'jwbaldwin/oscura.nvim' }

  local palettes = {
    nightfox = {
      -- Terminal colors
      black = {
        base = '#002831',
        bright = '#26444d',
        dim = '#0e1011',
      },
      red = {
        base = '#e63853',
        bright = '#e63853',
        dim = '#e63853',
      },
      green = {
        base = '#5eb83c',
        bright = '#5eb83c',
        dim = '#5eb83c',
      },
      yellow = {
        base = '#cd9409',
        bright = '#a57706',
        dim = '#cd9409',
      },
      blue = {
        base = '#359ddf',
        bright = '#359ddf',
        dim = '#005794',
      },
      magenta = {
        base = '#d75cff',
        bright = '#d75cff',
        dim = '#d75cff',
      },
      cyan = {
        base = '#4b73a2',
        bright = '#359ddf',
        dim = '#005794',
      },
      white = {
        base = '#dcdcdc',
        bright = '#ffffff',
        dim = '#7c8fa4',
      },

      orange = '#cd9409',
      pink = '#d75cff',

      -- Background hierarchy
      bg0 = '#0e1011',
      bg1 = '#0e1011',
      bg2 = '#002831',
      bg3 = '#26444d',
      bg4 = '#26444d',

      -- Foreground hierarchy
      fg0 = '#ffffff',
      fg1 = '#e2e2e2',
      fg2 = '#dcdcdc',
      fg3 = '#7c8fa4',

      -- Selection and comments
      sel0 = '#26444d',
      sel1 = '#005794',
      comment = '#708284',
    },
  }
  -- local palettes = {
  --   nightfox = {
  --     black = '#000000',
  --     red = '#FF0000', -- FL RED
  --     green = '#00A645', -- GREEN
  --     yellow = '#FFBF00', -- YELLOW
  --     blue = '#0000FF', -- BLUE
  --     magenta = '#FF00FF', -- MAGENTA
  --     cyan = '#006666', -- CYAN
  --     white = '#FFFFFF',
  --     orange = '#FF6600', -- FL ORANGE
  --     pink = '#FF00FF', -- FL MAGENTA
  --   },
  -- }

  require('nightfox').setup {
    options = {
      transparent = true,
    },
    palettes = palettes,
    groups = {
      nightfox = {
        WinSeparator = { fg = 'bg2' },
        StatusLine = { bg = '#000000' },
      },
    },
  }

  vim.pack.add { gh 'nvim-mini/mini.base16' }
  vim.pack.add { gh 'zenbones-theme/zenbones.nvim' }
  vim.pack.add { gh 'rktjmp/lush.nvim' }

  vim.g.nordbones_transparent_background = true
  vim.g.neobones_transparent_background = true
  vim.g.duckbones_transparent_background = true

  vim.pack.add { gh 'andreypopp/vim-colors-plain' }

  vim.pack.add { gh 'oskarnurm/koda.nvim' }
  vim.pack.add { gh 'mcauley-penney/techbase.nvim' }
  vim.pack.add { gh 'vague-theme/vague.nvim' }
  -- vim.pack.add { gh 'm4xshen/hardtime.nvim' }
  -- require('hardtime').setup()
  require('koda').setup {
    -- transparent = true,
  }
  require('techbase').setup {
    italic_comments = false,
    -- transparent = true,
    hl_overrides = {},
  }
  vim.pack.add { gh 'sirzif/tzfn.nvim' }
  vim.pack.add { gh 'webhooked/kanso.nvim' }
  vim.pack.add { gh 'wtfox/luna.nvim' }
  vim.pack.add { gh 'WeiTing1991/suannhai.nvim' }
  require('suannhai').setup {}
  vim.pack.add { gh 'kyzabuilds/xeno.nvim' }
  local xeno = require 'xeno'

  -- Method 1: Use xeno.setup() for direct configuration
  xeno.color('aurora', '#3ddc97')
  xeno.color('teal', '#2ec4b6')
  xeno.color('cyan', '#4fd9e8')
  xeno.color('ice', '#8ecae6')
  xeno.color('frost', '#a8e6cf')
  xeno.color('violet', '#9b7fd4')
  xeno.color('indigo', '#7c93e0')
  xeno.color('glow_pink', '#e39fc2')

  xeno.theme('polarized', {
    background = '#0a141c',
    accent = '#3ddc97',
    foreground = '#c9dde2',
    properties = {
      contrast = 0.10,
      chroma = 0.05,
      lightness = -0.05,
      variation = 0.10,
    },

    highlights = {
      editor = {
        CursorLineNr = { fg = '@frost.100', bold = true },
        MatchParen = { fg = '@frost.100', bold = true },
        Visual = { bg = xeno.opaque('@aurora.500', 0.18) },
        CursorLine = { bg = xeno.opaque('@teal.600', 0.06) },
        Search = { bg = xeno.opaque('@cyan.400', 0.25), fg = '@foreground.50' },
        IncSearch = { bg = xeno.opaque('@frost.300', 0.35), fg = '@background.950' },
      },

      syntax = {
        Comment = { fg = '@foreground.400', italic = true },
        Keyword = { fg = '@violet.300' },
        Conditional = { fg = '@indigo.300' },
        Function = { fg = '@teal.300' },
        Type = { fg = '@cyan.200' },
        String = { fg = '@aurora.100' },
        Number = { fg = '@frost.100' },
        Boolean = { fg = '@frost.100' },
        Variable = { fg = '@foreground.300' },
        Property = { fg = '@ice.300' },
        Operator = { fg = '@cyan.300' },
        Punctuation = { fg = '@foreground.400' },

        ['@keyword'] = { link = 'Keyword' },
        ['@keyword.return'] = { link = 'Keyword' },
        ['@keyword.function'] = { link = 'Conditional' },
        ['@keyword.conditional'] = { link = 'Conditional' },
        ['@keyword.repeat'] = { link = 'Conditional' },
        ['@keyword.operator'] = { fg = '@cyan.300' },
        ['@keyword.import'] = { fg = '@teal.400' },

        ['@function'] = { link = 'Function' },
        ['@function.builtin'] = { fg = '@cyan.100' },

        ['@type'] = { link = 'Type' },

        ['@string'] = { link = 'String' },
        ['@string.escape'] = { fg = '@ice.100' },

        ['@number'] = { link = 'Number' },
        ['@boolean'] = { link = 'Boolean' },

        ['@constant'] = { fg = '@frost.200' },
        ['@constant.builtin'] = { fg = '@glow_pink.100', bold = true },

        ['@variable'] = { link = 'Variable' },
        ['@variable.builtin'] = { fg = '@indigo.200' },

        ['@property'] = { link = 'Property' },

        ['@constructor'] = { fg = '@foreground.400' },

        ['@operator'] = { link = 'Operator' },
        ['@punctuation'] = { link = 'Punctuation' },
        ['@punctuation.bracket'] = { link = 'Punctuation' },
        ['@punctuation.delimiter'] = { link = 'Punctuation' },

        ['@lsp.type.variable'] = { link = '@variable' },
        ['@lsp.type.property'] = { link = '@property' },
        ['@lsp.type.function'] = { link = '@function' },
        ['@lsp.type.type'] = { link = '@type' },
        ['@lsp.type.keyword'] = { link = '@keyword' },
        ['@lsp.mod.declaration'] = { clear = true },
        ['@lsp.typemod.property.declaration'] = { link = '@property' },
      },
    },
  })
  xeno.theme('sapphire', {
    -- background = '#1a2332',
    background = '#000000',
    accent = '#4d8fd6',
    properties = {
      variation = 0.60,
      lightness = -0.10,
      chroma = 0.30,
    },
  })
  -- vim.pack.add { { src = 'https://github.com/kepano/flexoki', name = 'flexoki' } }
  require('tzfn').setup {
    enable = {
      terminal = true,
    },
    styles = {
      transparency = true,
    },
  }
  vim.pack.add { gh 'rjshkhr/shadow.nvim' }
  vim.pack.add { gh 'stevearc/oil.nvim' }
  require('oil').setup()
  vim.pack.add { gh 'embark-theme/vim' }
  vim.pack.add { gh 'yorumicolors/yorumi.nvim' }
  vim.pack.add { gh 'dasupradyumna/midnight.nvim' }
  vim.pack.add { gh 'dchinmay2/alabaster.nvim' }
  vim.cmd.colorscheme 'control-room'
  -- vim.cmd.colorscheme 'usgc-reticle'

  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'
  vim.pack.add { gh 'soemre/commentless.nvim' }
  require('commentless').setup {}
  -- vim.opt.foldminlines = 0 -- Allow folding/hiding single lines
  vim.opt.fillchars = 'fold: ' -- Remove the trailing dots
  vim.keymap.set('n', '<leader>1', function() require('commentless').toggle() end)
  --
  -- vim.keymap.set('n', '<leader>z', function() require('commentless').toggle() end)
  -- vim.pack.add { gh 'chrisgrieser/nvim-origami' }
  --
  -- vim.opt.foldlevel = 99
  -- vim.opt.foldlevelstart = 99
  --
  -- require('origami').setup {
  --   useLspFoldsWithTreesitterFallback = {
  --     enabled = true,
  --     foldmethodIfNeitherIsAvailable = 'indent', ---@type string|fun(bufnr: number): string
  --   },
  --   autoFold = {
  --     enabled = true,
  --     kinds = { 'comment', 'imports' }, ---@type lsp.FoldingRangeKind[]
  --   },
  -- }
  -- vim.api.nvim_create_autocmd('LspNotify', {
  --   callback = function(ctx)
  --     if ctx.data.method ~= 'textDocument/didOpen' then return end
  --     if vim.bo[ctx.buf].buftype ~= '' then return end
  --     vim.schedule(function()
  --       local client = vim.lsp.get_clients({ bufnr = ctx.buf, id = ctx.data.client_id })[1]
  --       if not client or not client:supports_method 'textDocument/foldingRange' then return end
  --       local winid = vim.fn.bufwinid(ctx.buf)
  --       if winid == -1 then return end
  --       local tries = 0
  --       local function try()
  --         if not vim.api.nvim_win_is_valid(winid) or vim.api.nvim_win_get_buf(winid) ~= ctx.buf then return end
  --         tries = tries + 1
  --         local closed = vim.api.nvim_win_call(winid, function()
  --           vim.fn.foldlevel(1) -- force creation of the LSP fold state
  --           pcall(vim.lsp.foldclose, 'comment', winid)
  --           return vim.fn.foldclosed(1)
  --         end)
  --         if closed == -1 and tries < 10 then vim.defer_fn(try, 200) end
  --       end
  --       try()
  --     end)
  --   end,
  -- })

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()
end

do
  ---@type (string|vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
    gh 'nvim-telescope/telescope-file-browser.nvim',
  }

  vim.pack.add(telescope_plugins)

  require('telescope').setup {
    defaults = {},
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
      },
    },
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
      file_browser = {
        preview = {
          ls_short = true,
        },
      },
    },
  }

  pcall(require('telescope').load_extension, 'ui-select')

  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
    end,
  })

  vim.keymap.set(
    'n',
    '<leader>/',
    function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = false,
      })
    end,
    { desc = '[/] Fuzzily search in current buffer' }
  )

  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    { desc = '[S]earch [/] in Open Files' }
  )

  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[S]earch [N]eovim files' })
end

do
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  ---@type table<string, vim.lsp.Config>
  local servers = {
    gopls = {},
    ty = {},
    rust_analyzer = {},
    ts_ls = {},
    stylua = {},
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
        client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
              '${3rd}/luv/library',
              '${3rd}/busted/library',
            }),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false },
          semantic = { enable = false, annotation = false, keyword = false, variable = false },
        },
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  require('mason').setup {}

  require('mason-lspconfig').setup {
    automatic_enable = false,
  }

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {})

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

do
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local enabled_filetypes = {
        lua = true,
        python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      rust = { 'rustfmt' },
      python = { 'ruff' },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
end

do
  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      preset = 'default',
    },

    appearance = {},

    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
      menu = {
        draw = {
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind' } },
        },
      },
    },

    sources = {
      default = { 'lsp', 'path' },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    signature = { enabled = true },
  }
end

do
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    if not vim.treesitter.language.add(language) then return end
    vim.treesitter.start(buf, language)

    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

do
  require 'custom.plugins'
end
-- vim: ts=2 sts=2 sw=2 et
