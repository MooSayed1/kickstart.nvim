local M = {}

local function session_name()
  local path = vim.api.nvim_buf_get_name(0)
  if vim.bo.filetype == 'NvimTree' then
    local node = require('nvim-tree.api').tree.get_node_under_cursor()
    path = node and node.absolute_path or ''
  end
  local root = vim.fs.root(path ~= '' and path or vim.fn.getcwd(), { '.git', 'CMakeLists.txt' }) or vim.fn.getcwd()
  return vim.fn.fnamemodify(root, ':t') .. '-' .. vim.fn.sha256(root):sub(1, 12) .. '.vim'
end

function M.setup()
  local sessions = require 'mini.sessions'
  sessions.setup {
    directory = vim.fn.stdpath('state') .. '/sessions',
    file = '',
    autoread = false,
    autowrite = false,
  }
  -- Restore files and layouts without restarting terminal jobs.
  vim.opt.sessionoptions:remove 'terminal'
  vim.keymap.set('n', '<leader>ps', function()
    sessions.write(session_name())
  end, { desc = '[P]roject: [S]ave session' })
  vim.keymap.set('n', '<leader>pr', function()
    local name = session_name()
    if not sessions.detected[name] then
      vim.notify('No saved session for this project. Save one with Space ps.', vim.log.levels.INFO)
      return
    end
    local ok, err = pcall(sessions.read, name, { force = false })
    if not ok then
      vim.notify(tostring(err), vim.log.levels.WARN)
    end
  end, { desc = '[P]roject: [R]estore session' })
end

return M
