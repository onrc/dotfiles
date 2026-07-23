require('mini.base16').setup({
  palette = {
    -- Background hierarchy
    base00 = "#0e1011", -- Normal background
    -- base01 = "#002831", -- Float, popup, cursor line, sign column
    base01 = "#0e1011", -- Float, popup, cursor line, sign column
    -- base02 = "#26444d", -- Selection, statusline, match-paren
    base02 = "#002831", -- Selection, statusline, match-paren
    -- base03 = "#708284", -- Comments, line numbers, non-text
    base03 = "#26444d", -- Comments, line numbers, non-text

    -- Foreground hierarchy
    base04 = "#7c8fa4", -- Secondary foreground
    base05 = "#dcdcdc", -- Primary foreground and variables
    base06 = "#e2e2e2", -- Bright foreground
    base07 = "#ffffff", -- Brightest foreground

    -- Syntax colors rearranged for Nightfox semantics
    base08 = "#359ddf", -- Statements and identifier fallback
    base09 = "#e63853", -- Constants, numbers, booleans
    base0A = "#a57706", -- Types
    base0B = "#5eb83c", -- Strings
    base0C = "#4b73a2", -- Cyan and special fallback
    -- base0D = "#5eb83c", -- Functions
    base0D = "#e63853", -- Constants, numbers, booleans
    base0E = "#359ddf", -- Keywords
    base0F = "#7c8fa4", -- Brackets and delimiters
  },
  -- palette = {
  --   base00 = '#0e1011', -- background
  --   base01 = '#002831', -- black
  --   base02 = '#26444d', -- bright black
  --   base03 = '#708284', -- cursor / comments
  --   base04 = '#7c8fa4', -- foreground
  --   base05 = '#dcdcdc', -- primary foreground
  --   base06 = '#e2e2e2', -- bright foreground
  --   base07 = '#ffffff', -- brightest foreground
  --   base08 = '#e63853', -- red
  --   base09 = '#cd9409', -- bright yellow/orange
  --   base0A = '#a57706', -- yellow
  --   base0B = '#5eb83c', -- green
  --   base0C = '#4b73a2', -- cyan
  --   base0D = '#359ddf', -- blue
  --   base0E = '#d75cff', -- magenta
  --   base0F = '#005794', -- dark cyan/blue
  -- },
  use_cterm = false,
  -- plugins = {
  --   default = false,
  --   ['nvim-mini/mini.nvim'] = true,
  -- },
})

-- 1. Left number/sign/fold column background
-- vim.api.nvim_set_hl(0, 'LineNr', {
--   fg = '#26444d',
--   bg = '#0e1011',
-- })
--
-- vim.api.nvim_set_hl(0, 'CursorLineNr', {
--   fg = '#e2e2e2',
--   bg = '#0e1011',
--   bold = true,
-- })
--
-- vim.api.nvim_set_hl(0, 'SignColumn', {
--   bg = '#0e1011',
-- })
--
-- vim.api.nvim_set_hl(0, 'FoldColumn', {
--   bg = '#0e1011',
-- })
--
-- -- 2. Statusline background
vim.api.nvim_set_hl(0, 'StatusLine', {
  fg = '#7c8fa4',
  bg = '#0e1011',
})

-- vim.api.nvim_set_hl(0, 'StatusLineNC', {
--   fg = '#708284',
--   bg = '#0e1011',
-- })
--
-- vim.api.nvim_set_hl(0, 'GitSignsChange', {
--   fg = '#cd9409',
--   bg = '#0e1011',
-- })
--
-- vim.api.nvim_set_hl(0, 'GitSignsAdd', {
--   fg = '#5eb83c',
--   bg = '#0e1011',
-- })
--
-- vim.api.nvim_set_hl(0, 'GitSignsDelete', {
--   fg = '#e63853',
--   bg = '#0e1011',
-- })
--
vim.api.nvim_set_hl(0, 'WinSeparator', {
  fg = '#002831',
  bg = '#0e1011',
})
--
-- vim.api.nvim_set_hl(0, 'NormalFloat', {
--   -- fg = '#002831',
--   bg = '#0e1011',
-- })
--
vim.api.nvim_set_hl(0, 'MiniPickPrompt', {
  fg = '#e2e2e2',
  bg = '#0e1011',
})
--
-- vim.api.nvim_set_hl(0, 'MiniPickPromptPrefix', {
--   fg = '#e2e2e2',
--   bg = '#0e1011',
-- })
--
-- vim.api.nvim_set_hl(0, 'MiniPickPromptCaret', {
--   fg = '#e2e2e2',
--   bg = '#0e1011',
-- })
--
-- vim.api.nvim_set_hl(0, 'MiniPickBorderText', {
--   fg = '#e2e2e2',
--   bg = '#0e1011',
-- })
--
vim.api.nvim_set_hl(0, 'MiniFilesTitle', {
  fg = '#e2e2e2',
  bg = '#0e1011',
})

vim.api.nvim_set_hl(0, 'MiniFilesTitleFocused', {
  fg = '#e2e2e2',
  bg = '#0e1011',
})
-- MiniPickHeader

-- hi('GitSignsAdd',             {fg=p.base0B, bg=p.base01, attr=nil, sp=nil})
-- hi('GitSignsAddLn',           {link='GitSignsAdd'})
-- hi('GitSignsAddInline',       {link='GitSignsAdd'})
--
-- hi('GitSignsChange',          {fg=p.base0E, bg=p.base01, attr=nil, sp=nil})
-- hi('GitSignsChangeLn',        {link='GitSignsChange'})
-- hi('GitSignsChangeInline',    {link='GitSignsChange'})
--
-- hi('GitSignsDelete',          {fg=p.base08, bg=p.base01, attr=nil, sp=nil})
-- hi('GitSignsDeleteLn',        {link='GitSignsDelete'})
-- hi('GitSignsDeleteInline',    {link='GitSignsDelete'})
--
-- hi('GitSignsUntracked',       {fg=p.base0D, bg=p.base01, attr=nil, sp=nil})
-- hi('GitSignsUntrackedLn',     {link='GitSignsUntracked'})
-- hi('GitSignsUntrackedInline', {link='GitSignsUntracked'})
