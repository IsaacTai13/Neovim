-- Key mapping
vim.g.mapleader = " " -- map <Space> as leader key
vim.g.maplocalleader = " "

-- Appearance
vim.opt.cmdheight = 1
vim.opt.relativenumber = true
vim.g.have_nerd_font = true

vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.list = false
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.autoread = true
vim.opt.ruler = true
vim.opt.showtabline = 0
vim.opt.shortmess = 'I'
vim.opt.equalalways = true
vim.opt.statusline = "%F"  -- Show full path in status line
vim.opt.showbreak='↳ '
vim.opt.conceallevel = 0   -- Show `` in markdown file
vim.opt.wildmenu = true
vim.opt.wildmode = 'full,full'
vim.opt.previewheight = 15
vim.opt.pumheight = 6      -- Set pop up windows max height


vim.opt.backspace = '2'
vim.opt.autoread = true
vim.opt.laststatus = 2

vim.opt.shiftround = true --  aligns the indentation to the nearest multiple of shiftwidth when using >> and << commands

-- Split window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Sound
vim.opt.visualbell = false
vim.opt.errorbells = false   -- Turn off errorbells

-- Configuration
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.clipboard = 'unnamed'
vim.opt.swapfile = false
vim.opt.hidden = true
vim.o.omnifunc = 'syntaxcomplete#Complete'
vim.opt.compatible = false

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- When I open a file in Neovim, it automatically displays the full file path.
-- When the path is too long, it triggers a “Press ENTER to continue” prompt before I can start editing — which is really annoying.
-- To fix this, I used the following setting to suppress the echo of the full file path:
-- Adding "F" prevents this message from appearing, so you won’t be interrupted with a “Press ENTER to continue” prompt every time you open a file.
vim.opt.shortmess:append("WF")
