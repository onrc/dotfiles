local autocmd = vim.api.nvim_create_autocmd
local function augroup(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

autocmd('BufWinEnter', {
  group = augroup 'cursor',
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if not (ft:match 'commit' or ft:match 'rebase' or ft == 'xxd' or vim.wo.diff) then pcall(vim.cmd.normal, { [[g`"]], bang = true }) end
  end,
})
