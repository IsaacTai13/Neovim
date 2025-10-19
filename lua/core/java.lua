-- Compile java code
vim.keymap.set('n', '<leader>jc', ':!javac %<CR>', { desc = 'Compile Java' })

-- Compile and run current Java file in a split terminal window (any key to close it)
vim.keymap.set('n', '<leader>jr', function()
  -- Get current file relative path
  local file = vim.fn.expand('%')

  -- Extract full class name (e.g., "ds.Stack" from "/path/LeetCode/ds/Stack.java")
  local class_name = vim.fn.expand('%:p'):match('LeetCode/(.+)%.java'):gsub('/', '.')

  -- Open a 10-line terminal at the bottom and execute compile + run
  vim.cmd('belowright 10split | terminal javac ' .. file .. ' && java ' .. class_name)

  -- Automatically enter insert mode to view output
  vim.cmd('startinsert')
end, { desc = 'Compile and Run' })

-- Compile and run current Java file in a split terminal window (Manual Close with <CR>)
vim.keymap.set('n', '<leader>jt', function()
  -- Get current file relative path
  local file = vim.fn.expand('%')

  -- Extract full class name (e.g., "ds.Stack" from "/path/LeetCode/ds/Stack.java")
  local class_name = vim.fn.expand('%:p'):match('LeetCode/(.+)%.java'):gsub('/', '.')

  -- Add a shell command to keep terminal open after execution
  vim.cmd('belowright 10split | terminal javac ' .. file .. ' && java ' .. class_name .. '; echo "\\nPress ENTER to close"; read')
end, { desc = 'Compile and Run (No close)' })

