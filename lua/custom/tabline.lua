local M = {}

local function tab_buffer(tab)
  local current = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab))
  if vim.bo[current].buftype == '' then
    return current
  end
  -- Keep the file's name visible while the explorer or terminal has focus.
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == '' then
      return buf
    end
  end
  return current
end

function M.render()
  local tabs = vim.api.nvim_list_tabpages()
  local selected = vim.api.nvim_get_current_tabpage()
  local result = { '%#TabLineFill# ' }
  for index, tab in ipairs(tabs) do
    local buf = tab_buffer(tab)
    local path = vim.api.nvim_buf_get_name(buf)
    local name = path ~= '' and vim.fn.fnamemodify(path, ':t') or '[New tab]'
    if vim.bo[buf].buftype == 'terminal' then
      name = 'Terminal'
    elseif vim.bo[buf].filetype == 'NvimTree' then
      name = 'Explorer'
    end
    -- Escape filenames so '%' cannot be interpreted as tabline formatting.
    name = name:gsub('%%', '%%%%'):gsub('[%c]', ' ')
    local modified = vim.bo[buf].modified and ' [+]' or ''
    result[#result + 1] = ('%%%dT%%#%s# %d  %s%s %%T%%#TabLineFill# '):format(
      index, tab == selected and 'CodingTabActive' or 'CodingTabInactive', index, name, modified
    )
  end
  result[#result + 1] = '%=%#TabLineFill# Tab / Shift-Tab  '
  return table.concat(result)
end

function M.setup()
  local function highlights()
    vim.api.nvim_set_hl(0, 'CodingTabActive', { fg = '#282c34', bg = '#61afef', bold = true })
    vim.api.nvim_set_hl(0, 'CodingTabInactive', { fg = '#abb2bf', bg = '#21252b' })
  end
  highlights()
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('coding-tabline', { clear = true }),
    callback = highlights,
  })
  vim.o.showtabline = 2
  vim.o.tabline = "%!v:lua.require('custom.tabline').render()"
end

return M
