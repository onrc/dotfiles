do
  vim.loader.enable()

  vim.cmd 'filetype plugin indent on'

  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  vim.g.have_nerd_font = false

  vim.o.number = true

  vim.o.wrap = false
  vim.o.mouse = 'a'

  vim.o.showmode = false

  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  vim.o.breakindent = true

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
local function gh(repo) return 'https://github.com/' .. repo end

do
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {}

  -- vim.pack.add { gh 'edeneast/nightfox.nvim' }
  -- local palettes = {
  --   nightfox = {
  --     -- Terminal colors
  --     black = {
  --       base = "#002831",
  --       bright = "#26444d",
  --       dim = "#0e1011",
  --     },
  --     red = {
  --       base = "#e63853",
  --       bright = "#e63853",
  --       dim = "#e63853",
  --     },
  --     green = {
  --       base = "#5eb83c",
  --       bright = "#5eb83c",
  --       dim = "#5eb83c",
  --     },
  --     yellow = {
  --       base = "#cd9409",
  --       bright = "#a57706",
  --       dim = "#cd9409",
  --     },
  --     blue = {
  --       base = "#359ddf",
  --       bright = "#359ddf",
  --       dim = "#005794",
  --     },
  --     magenta = {
  --       base = "#d75cff",
  --       bright = "#d75cff",
  --       dim = "#d75cff",
  --     },
  --     cyan = {
  --       base = "#4b73a2",
  --       bright = "#359ddf",
  --       dim = "#005794",
  --     },
  --     white = {
  --       base = "#dcdcdc",
  --       bright = "#ffffff",
  --       dim = "#7c8fa4",
  --     },
  --
  --     orange = "#cd9409",
  --     pink = "#d75cff",
  --
  --     -- Background hierarchy
  --     bg0 = "#0e1011",
  --     bg1 = "#0e1011",
  --     bg2 = "#002831",
  --     bg3 = "#26444d",
  --     bg4 = "#26444d",
  --
  --     -- Foreground hierarchy
  --     fg0 = "#ffffff",
  --     fg1 = "#e2e2e2",
  --     fg2 = "#dcdcdc",
  --     fg3 = "#7c8fa4",
  --
  --     -- Selection and comments
  --     sel0 = "#26444d",
  --     sel1 = "#005794",
  --     comment = "#708284",
  --   },
  -- }
  --
  -- require('nightfox').setup {
  --   palettes = palettes,
  --   groups = {
  --     nightfox = {
  --       WinSeparator = { fg = "bg2" }
  --     }
  --   }
  -- }

  vim.pack.add { 'https://github.com/nvim-mini/mini.base16' }
  vim.cmd.colorscheme 'minifox'

  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  require('mini.ai').setup {
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  require('mini.files').setup {
    options = {
      permanent_delete = true,
      use_as_default_explorer = true,
      lsp_timeout = 1000,
    },
    windows = {
      max_number = math.huge,
      preview = true,
      width_focus = 25,
      width_nofocus = 15,
      width_preview = 50,
    },
    content = { prefix = function() end },
  }

  vim.keymap.set('n', '<leader>ft', function() MiniFiles.open() end)

  require('mini.pick').setup {}
  require('mini.surround').setup()
end

do
  vim.keymap.set('n', '<leader>sf', '<cmd>Pick files<CR>', { desc = '' })
  vim.keymap.set('n', '<leader><leader>', '<cmd>Pick buffers<CR>', { desc = '' })
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
    end,
  })

  ---@type table<string, vim.lsp.Config>
  local servers = {
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},

    stylua = {},

    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
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
      -- rust = { 'rustfmt' },
      -- python = { "isort", "black" },
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

    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = { implementation = 'lua' },

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
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

do
  local nsMiniFiles = vim.api.nvim_create_namespace 'mini_files_git'
  local autocmd = vim.api.nvim_create_autocmd
  local _, MiniFiles = pcall(require, 'mini.files')

  local gitStatusCache = {}
  local cacheTimeout = 2000
  local uv = vim.uv or vim.loop

  local function isSymlink(path)
    local stat = uv.fs_lstat(path)
    return stat and stat.type == 'link'
  end

  ---@type table<string, {symbol: string, hlGroup: string}>
  ---@param status string
  ---@return string symbol, string hlGroup
  local function mapSymbols(status, is_symlink)
    local statusMap = {
      -- stylua: ignore start 
      [" M"] = { symbol = "", hlGroup  = "MiniDiffSignChange"},
      ["M "] = { symbol = "", hlGroup  = "MiniDiffSignChange"},
      ["MM"] = { symbol = "", hlGroup  = "MiniDiffSignChange"},
      ["A "] = { symbol = "", hlGroup  = "MiniDiffSignAdd"   },
      ["AA"] = { symbol = "", hlGroup  = "MiniDiffSignAdd"   },
      ["D "] = { symbol = "", hlGroup  = "MiniDiffSignDelete"},
      ["AM"] = { symbol = "", hlGroup  = "MiniDiffSignChange"},
      ["AD"] = { symbol = "", hlGroup  = "MiniDiffSignChange"},
      ["R "] = { symbol = "", hlGroup  = "MiniDiffSignChange"},
      ["U "] = { symbol = "", hlGroup  = "MiniDiffSignChange"},
      ["UU"] = { symbol = "", hlGroup  = "MiniDiffSignAdd"   },
      ["UA"] = { symbol = "", hlGroup  = "MiniDiffSignAdd"   },
      ["??"] = { symbol = "", hlGroup  = "MiniDiffSignDelete"},
      ["!!"] = { symbol = "", hlGroup  = "MiniDiffSignChange"},
    }

    local result = statusMap[status] or { symbol = '?', hlGroup = 'NonText' }
    local gitSymbol = result.symbol
    local gitHlGroup = result.hlGroup

    local symlinkSymbol = is_symlink and '↩' or ''

    local combinedSymbol = (symlinkSymbol .. gitSymbol):gsub('^%s+', ''):gsub('%s+$', '')
    local combinedHlGroup = is_symlink and 'MiniDiffSignDelete' or gitHlGroup

    return combinedSymbol, combinedHlGroup
  end

  ---@param cwd string
  ---@param callback function
  ---@return nil
  local function fetchGitStatus(cwd, callback)
    local clean_cwd = cwd:gsub('^minifiles://%d+/', '')
    ---@param content table
    local function on_exit(content)
      if content.code == 0 then callback(content.stdout) end
    end
    ---@see vim.system
    vim.system({ 'git', 'status', '--ignored', '--porcelain' }, { text = true, cwd = clean_cwd }, on_exit)
  end

  ---@param buf_id integer
  ---@param gitStatusMap table
  ---@return nil
  local function updateMiniWithGit(buf_id, gitStatusMap)
    vim.schedule(function()
      local nlines = vim.api.nvim_buf_line_count(buf_id)
      local cwd = vim.fs.root(buf_id, '.git')
      local escapedcwd = cwd and vim.pesc(cwd)
      escapedcwd = vim.fs.normalize(escapedcwd)

      for i = 1, nlines do
        local entry = MiniFiles.get_fs_entry(buf_id, i)
        if not entry then break end
        local relativePath = entry.path:gsub('^' .. escapedcwd .. '/', '')
        local status = gitStatusMap[relativePath]

        if status then
          local symbol, hlGroup = mapSymbols(status, isSymlink(entry.path))
          vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
            sign_text = symbol,
            sign_hl_group = hlGroup,
            priority = 2,
          })
          local line = vim.api.nvim_buf_get_lines(buf_id, i - 1, i, false)[1]
          local nameStartCol = line:find(vim.pesc(entry.name)) or 0

          if nameStartCol > 0 then
            vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, nameStartCol - 1, {
              end_col = nameStartCol + #entry.name - 1,
              hl_group = hlGroup,
            })
          end
        else
        end
      end
    end)
  end

  ---@param content string
  ---@return table
  local function parseGitStatus(content)
    local gitStatusMap = {}
    for line in content:gmatch '[^\r\n]+' do
      local status, filePath = string.match(line, '^(..)%s+(.*)')
      local parts = {}
      for part in filePath:gmatch '[^/]+' do
        table.insert(parts, part)
      end
      local currentKey = ''
      for i, part in ipairs(parts) do
        if i > 1 then
          currentKey = currentKey .. '/' .. part
        else
          currentKey = part
        end
        if i == #parts then
          gitStatusMap[currentKey] = status
        else
          if not gitStatusMap[currentKey] then gitStatusMap[currentKey] = status end
        end
      end
    end
    return gitStatusMap
  end

  ---@param buf_id integer
  ---@return nil
  local function updateGitStatus(buf_id)
    if not vim.fs.root(buf_id, '.git') then return end
    local cwd = vim.fs.root(buf_id, '.git')
    local currentTime = os.time()

    if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
      updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
    else
      fetchGitStatus(cwd, function(content)
        local gitStatusMap = parseGitStatus(content)
        gitStatusCache[cwd] = {
          time = currentTime,
          statusMap = gitStatusMap,
        }
        updateMiniWithGit(buf_id, gitStatusMap)
      end)
    end
  end

  ---@return nil
  local function clearCache() gitStatusCache = {} end

  local function augroup(name) return vim.api.nvim_create_augroup('MiniFiles_' .. name, { clear = true }) end

  autocmd('User', {
    group = augroup 'start',
    pattern = 'MiniFilesExplorerOpen',
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      updateGitStatus(bufnr)
    end,
  })

  autocmd('User', {
    group = augroup 'close',
    pattern = 'MiniFilesExplorerClose',
    callback = function() clearCache() end,
  })

  autocmd('User', {
    group = augroup 'update',
    pattern = 'MiniFilesBufferUpdate',
    callback = function(args)
      local bufnr = args.data.buf_id
      local cwd = vim.fs.root(bufnr, '.git')
      if gitStatusCache[cwd] then updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap) end
    end,
  })

  autocmd('BufWinEnter', {
    group = augroup 'cursor',
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
      if not (ft:match 'commit' or ft:match 'rebase' or ft == 'xxd' or vim.wo.diff) then pcall(vim.cmd.normal, { [[g`"]], bang = true }) end
    end,
  })
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
