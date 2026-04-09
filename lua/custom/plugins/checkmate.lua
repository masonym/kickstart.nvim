-- https://github.com/bngarren/checkmate.nvim
return {
  'bngarren/checkmate.nvim',
  ft = 'markdown', -- Lazy loads for Markdown files matching patterns in 'files'
  opts = {
    -- files = { "*.md" }, -- any .md file (instead of defaults)
    list_continuation = {
      enabled = true,
      split_line = true,
      keys = {
        ['<CR>'] = function()
          require('checkmate').create {
            position = 'below',
            indent = false,
          }
        end,
        ['<C-a>'] = function()
          require('checkmate').create {
            position = 'below',
            indent = true,
          }
        end,
      },
    },
    -- Default keymappings
    keys = {
      ['<leader>Tt'] = {
        rhs = '<cmd>Checkmate toggle<CR>',
        desc = 'Toggle todo item',
        modes = { 'n', 'v' },
      },
      ['ttd'] = {
        rhs = '<cmd>Checkmate toggle<CR>',
        desc = 'Toggle todo item',
        modes = { 'n', 'v' },
      },
      ['<leader>Tc'] = {
        rhs = '<cmd>Checkmate check<CR>',
        desc = 'Set todo item as checked (done)',
        modes = { 'n', 'v' },
      },
      ['<leader>Tu'] = {
        rhs = '<cmd>Checkmate uncheck<CR>',
        desc = 'Set todo item as unchecked (not done)',
        modes = { 'n', 'v' },
      },
      ['<leader>T='] = {
        rhs = '<cmd>Checkmate cycle_next<CR>',
        desc = 'Cycle todo item(s) to the next state',
        modes = { 'n', 'v' },
      },
      ['<leader>T-'] = {
        rhs = '<cmd>Checkmate cycle_previous<CR>',
        desc = 'Cycle todo item(s) to the previous state',
        modes = { 'n', 'v' },
      },
      ['<leader>Tn'] = {
        rhs = '<cmd>Checkmate create<CR>',
        desc = 'Create todo item',
        modes = { 'n', 'v' },
      },
      ['<leader>Tr'] = {
        rhs = '<cmd>Checkmate remove<CR>',
        desc = 'Remove todo marker (convert to text)',
        modes = { 'n', 'v' },
      },
      ['<leader>TR'] = {
        rhs = '<cmd>Checkmate remove_all_metadata<CR>',
        desc = 'Remove all metadata from a todo item',
        modes = { 'n', 'v' },
      },
      ['<leader>Ta'] = {
        rhs = '<cmd>Checkmate archive<CR>',
        desc = 'Archive checked/completed todo items (move to bottom section)',
        modes = { 'n' },
      },
      ['<leader>TF'] = {
        rhs = '<cmd>Checkmate select_todo<CR>',
        desc = 'Open a picker to select a todo from the current buffer',
        modes = { 'n' },
      },
      ['<leader>Tv'] = {
        rhs = '<cmd>Checkmate metadata select_value<CR>',
        desc = 'Update the value of a metadata tag under the cursor',
        modes = { 'n' },
      },
      ['<leader>T]'] = {
        rhs = '<cmd>Checkmate metadata jump_next<CR>',
        desc = 'Move cursor to next metadata tag',
        modes = { 'n' },
      },
      ['<leader>T['] = {
        rhs = '<cmd>Checkmate metadata jump_previous<CR>',
        desc = 'Move cursor to previous metadata tag',
        modes = { 'n' },
      },
    },
  },
  vim.keymap.set('n', 'o', function()
    local todo = require('checkmate').get_todo()

    if todo then
      require('checkmate').create {
        position = 'below',
        indent = false,
      }
    else
      vim.api.nvim_feedkeys('o', 'n', false)
    end
  end),
  vim.keymap.set('n', 'O', function()
    local todo = require('checkmate').get_todo()

    if todo then
      require('checkmate').create {
        position = 'below',
        indent = true,
      }
    else
      vim.api.nvim_feedkeys('O', 'n', false)
    end
  end),
}
