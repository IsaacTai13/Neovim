local helper = require("core.helper")
local mark = helper.safe_require("harpoon.mark")
local ui = helper.safe_require("harpoon.ui")

if not mark or not ui then
  print("fail to load harpoon")
  return
end

-- Custom function
function RemoveMark(param)
  if not param then
    print("Failed: No parameter provided")
    return
  end
  mark.rm_file(tonumber(param))
end

-- creates a custom Vim command called :RemoveMark
vim.cmd("command! -nargs=1 RemoveMark lua RemoveMark(<args>)")

local function map(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = desc })
end
map('<leader>ma', mark.add_file, '[M]ark [A]dd file')
map('<leader>mr', mark.rm_file, '[M]ark [R]emove file')
map('<leader>mc', mark.clear_all, '[M]ark [C]lear all')
map('<leader>mm', ui.toggle_quick_menu, '[M]ark [M]enu')
map('<leader>mn', ui.nav_next, '[M]ark [N]ext file')
map('<leader>mp', ui.nav_prev, '[M]ark [P]revious file')
map('<leader>m1', function() ui.nav_file(1) end, '[M]ark file 1')
map('<leader>m2', function() ui.nav_file(2) end, '[M]ark file 2')
map('<leader>m3', function() ui.nav_file(3) end, '[M]ark file 3')
map('<leader>m4', function() ui.nav_file(4) end, '[M]ark file 4')
map('<leader>md', function() helper.input_prompt('Enter mark index to remove: ', RemoveMark) end, '[M]ark [D]elete specific mark')

map(',m', ui.toggle_quick_menu, '[M]ark [M]enu')
map(',n', ui.nav_next, '[M]ark [N]ext file')
map(',p', ui.nav_prev, '[M]ark [P]revious file')
