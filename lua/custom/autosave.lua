local M = {}

local function save(buf)
  if not vim.g.autosave_enabled or not vim.api.nvim_buf_is_loaded(buf) then
    return
  end
  local opts = vim.bo[buf]
  if opts.buftype ~= '' or not opts.modifiable or opts.readonly or not opts.modified then
    return
  end
  local path = vim.api.nvim_buf_get_name(buf)
  -- New files need an explicit first save; never force writes or create paths.
  if path == '' or vim.fn.filereadable(path) ~= 1 or vim.fn.filewritable(path) ~= 1 then
    return
  end
  local ok, err = pcall(vim.api.nvim_buf_call, buf, function()
    -- Keep normal write hooks, including format-on-save.
    vim.cmd 'silent update'
  end)
  if not ok then
    vim.notify('Autosave failed: ' .. tostring(err), vim.log.levels.WARN)
  end
end

function M.setup()
  vim.g.autosave_enabled = true
  local group = vim.api.nvim_create_augroup('coding-autosave', { clear = true })
  vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufLeave' }, {
    group = group,
    nested = true,
    callback = function(event)
      save(event.buf)
    end,
  })
  vim.api.nvim_create_autocmd('FocusLost', {
    group = group,
    nested = true,
    callback = function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        save(buf)
      end
    end,
  })
  vim.keymap.set('n', '<leader>ta', function()
    vim.g.autosave_enabled = not vim.g.autosave_enabled
    vim.notify('Autosave ' .. (vim.g.autosave_enabled and 'enabled' or 'disabled'))
  end, { desc = '[T]oggle [A]utosave' })
end

return M
