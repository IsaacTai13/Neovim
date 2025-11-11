-- Open or create file with absolute path prepend
vim.keymap.set("n", ",e", function()
  local path = vim.fn.expand('%:p:h') .. '/'
  vim.fn.feedkeys(':e ' .. path)
end, { desc = ":e and append current filepath" })


-- Rename the current file
vim.keymap.set("n", ",r", function()
  -- Get the full path of the current buffer's file
  local old_name = vim.api.nvim_buf_get_name(0)

  -- Get the current file's name relative to the working directory
  local old_short = vim.fn.expand('%')

  -- Prompt the user to input a new name, pre-filled with the current file name
  local new_name = vim.fn.input('Rename to: ', old_short)

  -- Proceed only if the new name is not empty and not the same as the current name
  if new_name ~= '' and new_name ~= old_short then
    -- Save the buffer under the new file name
    vim.cmd('saveas ' .. new_name)

    -- Delete the old file from the file system
    vim.fn.delete(old_name)

    -- Close the buffer that was associated with the old file
    vim.cmd('bdelete ' .. old_name)
  end
end, { desc = "Rename current file" })


-- In insert mode, this mapping makes the ";" key "smart":
-- If the character under the cursor is already a semicolon, pressing ";" will move the cursor to the right (skip it).
-- Otherwise, it inserts a semicolon as usual.
vim.keymap.set("i", ";", function()
  local col = vim.fn.col('.')
  local line = vim.fn.getline('.')
  if line:sub(col, col) == ";" then
    return "<Right>"
  else
    return ";"
  end
end, { expr = true, desc = "Jump over ; if already present" })


-- Reload Neovim configuration with notification
vim.keymap.set('n', '<leader>r', function()
  vim.cmd('source $MYVIMRC')
  vim.notify("✓ Config reloaded!", vim.log.levels.INFO)
end, { desc = 'Reload config' })


-- Issue: When creating a new file in an already-open Neovim session, syntax highlighting
-- Solution: Manually reload buffer to trigger Treesitter (useful for new files)
vim.keymap.set('n', ',t', ':edit<CR>', { desc = 'Reload buffer (trigger Treesitter)' })
