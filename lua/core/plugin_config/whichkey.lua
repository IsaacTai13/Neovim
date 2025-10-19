local helper = require("core.helper")
local wk = helper.safe_require("which-key")

wk.setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ...
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  layout = {
    width = { min = 20 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  keys = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  -- delay between pressing a key and opening which-key (milliseconds)
  -- this setting is independent of vim.o.timeoutlen
  delay = 0,
  -- show a warning when issues were detected with your mappings
  notify = true,
  icons = {
    -- set icon mappings to true if you have a Nerd Font
    mappings = vim.g.have_nerd_font,
    -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
    -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },
  --- You can add any mappings here, or use `require('which-key').add()` later
  ---@type wk.Spec
  spec = {
    { "<leader>s", group = "[S]earch" },
    { "<leader>l", group = "[L]sp" },
    { "<leader>m", group = "[M]ark (Harpoon)"},
    { "<leader>h", group = "[H]unk (Git)"},
    { "<leader>c", group = "[C]opilot"},
    { "<leader>t", group = "[T]oggle Term"},
    { "<leader>j", group = "[J]ava"},
  },
}

-- Floaterm group
-- wk.add({
--   { "<Space>f", group = "Floaterm" },
--   { "<Space>fc", "<cmd>FloatermNew<cr>", desc = "Create new floaterm" },
--   { "<Space>fn", "<cmd>FloatermNext<cr>", desc = "Next floaterm" },
--   { "<Space>fp", "<cmd>FloatermPrev<cr>", desc = "Previous floaterm" },
--   { "<Space>ff", "<cmd>FloatermFirst<cr>", desc = "First floaterm" },
--   { "<Space>fl", "<cmd>FloatermLast<cr>", desc = "Last floaterm" },
--   { "<Space>fT", "<cmd>FloatermToggle<cr>", desc = "Toggle floaterm window" },
--   { "<Space>fk", "<cmd>FloatermKill<cr>", desc = "Kill floaterm window" },
--   { "<Space>fb", "<cmd>FloatermNew! --height=0.2 --width=0.98 --wintype=normal --name=terminal --position=bottom --autoclose=1 cd %:p:h<cr>", desc = "Create button terminal" },
--   { "<Space>fg", "<cmd>FloatermNew! --height=0.98 --width=0.98 --wintype=float --name=lazygit --position=center --autoclose=1 lazygit<cr>", desc = "lazygit" },
--   { "<Space>ft", "<cmd>FloatermNew! --height=0.98 --width=0.98 --wintype=float --name=lazygit --position=center --autoclose=1 tig<cr>", desc = "tig" },
--   { "<Space>fa", "<cmd>FloatermNew! --height=0.98 --width=0.98 --wintype=float --name=lazygit --position=center --autoclose=1 tig --all<cr>", desc = "tig all reference" }
-- })


-- True-zen group
-- wk.add({
--   { "<Space>z", group = "True-zen" },
--   { "<Space>zn", function() local first = 1 local last = vim.api.nvim_buf_line_count(0) GlobTruezen.narrow(first, last) end, desc = "Narrow mode" },
--   { "<Space>zf", function() GlobTruezen.focus() end, desc = "Focus mode" },
--   { "<Space>zm", function() GlobTruezen.minimalist() end, desc = "Minimal mode" },
--   { "<Space>za", function() GlobTruezen.ataraxis() end, desc = "Ataraxis mode" },
--   { "<Space>zt", ":TZQuit<CR>", desc = "Exit Zen mode" },
-- })

-- System group
-- wk.add({
--   { "<Space>o", group = "Operation System" },
--   { "<Space>oj", ":horizontal resize -2<cr>", desc = "Decrease the height" },
--   { "<Space>ok", ":horizontal resize +2<cr>", desc = "Increase the height" },
--   { "<Space>oh", ":vertical resize -2<cr>", desc = "Expand the weight to left" },
--   { "<Space>ol", ":vertical resize +2<cr>", desc = "Shrink the weight to right" },
--   { "<Space>ob", ":bufdo bw!<cr>", desc = "Close all buffer without saving it" },
--   { "<Space>on", ":tabnext<cr>", desc = "Switch to next tab" },
--   { "<Space>op", ":tabprevious<cr>", desc = "Switch to prev tab" },
--   { "<Space>oc", ":tabnew<cr>", desc = "Create a new tab" },
--   { "<Space>os", ":sp<cr>", desc = "Split window horizontal" },
-- })

-- LSP group
-- wk.add({
--   { "<Space>l", group = "LSP" },
--   { "<Space>la", "<cmd>Lspsaga code_action<cr>", desc = "Action" },
--   { "<Space>lk", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
--   { "<Space>lg", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto definition" },
--   { "<Space>lh", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover doc" },
--   { "<Space>lH", "<cmd>Lspsaga hover_doc ++keep<cr>", desc = "Hover doc keep" },
--   { "<Space>lt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek type definition" },
--   { "<Space>lT", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
--   { "<Space>lR", "<cmd>Lspsaga project_replace<cr>", desc = "Project replace" },
--   { "<Space>lO", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
--   { "<Space>ls", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
--   { "<Space>ld", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line diagnostics" },
--   { "<Space>lb", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "Buffer diagnostics" },
--   { "<Space>lc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "Cursor diagnostics" },
--   { "<Space>ln", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Jump to next diagnostics" },
--   { "<Space>lp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Jump to prev diagnostics" },
--   { "<Space>lr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
--   { "<Space>lz", "<cmd>Lspsaga term_toggle<cr>", desc = "Terminal toggle" },
--   { "<Space>li", "<cmd>Lspsaga incoming_calls<cr>", desc = "Incoming calls" },
--   { "<Space>lo", "<cmd>Lspsaga outcoming_calls<cr>", desc = "Outcoming calls" },
--   { "<Space>lf", "<cmd>Lspsaga finder tyd+def+ref+imp<cr>", desc = "Finder tyd + def + ref + imp" },
--   { "<Space>lfi", "<cmd>Lspsaga finder imp<cr>", desc = "Finder implementation" },
--   { "<Space>lfr", "<cmd>Lspsaga finder ref<cr>", desc = "Finder reference" },
--   { "<Space>lft", "<cmd>Lspsaga finder tyd<cr>", desc = "Finder type definition" },
--   { "<Space>lF", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", desc = "Format" },
--   { "<Space>lI", "<cmd>LspInfo<cr>", desc = "Info" },
--   { "<Space>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix" },
--   { "<Space>lD", "<cmd>lua require('telescope.builtin').lsp_document_symbols<cr>", desc = "Document Symbols" },
-- })

-- -- Gitgutter group
-- wk.add({
--   { "<Space>g", group = "Gitgutter" },
--   { "<Space>gn", "<cmd>GitGutterNextHunk<cr>", desc = "Next hunk" },
--   { "<Space>gp", "<cmd>GitGutterPrevHunk<cr>", desc = "Prev hunk" },
--   { "<Space>gq", "<cmd>GitGutterQuickFix<cr>", desc = "Quickfix" },
--   { "<Space>gd", "<cmd>GitGutterDiffOrig<cr>", desc = "Diff" },
--   { "<Space>gf", "<cmd>GitGutterFold<cr>", desc = "Fold" },
--   { "<Space>gh", "<cmd>GitGutterLineHighlightsToggle<cr>", desc = "Toggle Highlight" },
--   { "<Space>ge", "<cmd>GitGutterLineNrHighlightsToggle<cr>", desc = "Toggle Number Highlight" },
--   { "<Space>gH", "<cmd>GitGutterStageHunk<cr>", desc = "Stage Hunk" },
--   { "<Space>gU", "<cmd>GitGutterUndoHunk<cr>", desc = "Undo Hunk" },
--   { "<Space>gP", "<cmd>GitGutterPreviewHunk<cr>", desc = "Preview Hunk" },
--   { "<Space>gs", "<cmd>GitGutterAll<cr>", desc = "Update signs across all buffer" },
--   { "<Space>gE", "<cmd>GitGutterBufferEnable<cr>", desc = "Buffer enable" },
--   { "<Space>gt", "<cmd>GitGutterBufferToggle<cr>", desc = "Buffer toggle" },
-- })

-- Neogit group
-- wk.add({
--     { "<Space>n", group = "Neogit" },
--   { "<Space>no", function() neogit.open() end, desc = "Open Neogit" },
--     { "<Space>nc", function() neogit.open({ "commit" }) end, desc = "Open Neogit commit window" },
--     { "<Space>nh", function() neogit.open({ kind = "split" }) end, desc = "Open horizontal" },
--     { "<Space>nv", function() neogit.open({ kind = "vsplit" }) end, desc = "Open vertical" },
--     { "<Space>nt", function() neogit.open({ kind = "tab" }) end, desc = "Open in tab" },
--     { "<Space>ny", function() neogit.open({ cwd = "~/.config/nvim/" }) end, desc = "Open nvim git repo" },
-- })

-- Conflict group
-- wk.add({
--   { "<Space>c", group = "Conflict" },
--   { "<Space>ca", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both" },
--   { "<Space>cb", "<cmd>GitConflictChooseBase<cr>", desc = "Choose base" },
--   { "<Space>cx", "<cmd>GitConflictChooseNone<cr>", desc = "Choose none" },
--   { "<Space>co", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose ours" },
--   { "<Space>ct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose theirs" },
--   { "<Space>cn", "<cmd>GitConflictNextConflict<cr>", desc = "Next conflict" },
--   { "<Space>cp", "<cmd>GitConflictPrevConflict<cr>", desc = "Prev conflict" },
--   { "<Space>cl", "<cmd>GitConflictListQf<cr>", desc = "List conflict" },
--   { "<Space>cr", "<cmd>GitConflictRefresh<cr>", desc = "Conflict refresh" },
-- })

-- DiffView group
-- wk.add({
--   { "<Space>d", group = "DiffView" },
--   { "<Space>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
--   { "<Space>dh", "<cmd>DiffviewFileHistory<cr>", desc = "History Current branch" },
--   { "<Space>df", "<cmd>DiffviewFileHistory %<cr>", desc = "History Current file" },
--   { "<Space>do", "<cmd>DiffviewOpen<cr>", desc = "Diffview with current index" },
--   { "<Space>da", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Diffview HEAD~1" },
--   { "<Space>db", "<cmd>DiffviewOpen HEAD~2<cr>", desc = "Diffview HEAD~2" },
--   { "<Space>dt", "<cmd>DiffviewToggleFiles<cr>", desc = "Diffview Toggle file" },
--   { "<Space>dr", "<cmd>DiffviewRefresh<cr>", desc = "Diffview Refresh" },
-- })

-- Others group
-- wk.add({
--   { "<Space>o", group = "Others" },
--   { "<Space>oe", "<cmd>ConvertToDecimal<cr><cr>", desc = "Convert whole page to Decimal" },
--   { "<Space>ou", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
--   { "<Space>ol", "<cmd>set relativenumber!<cr>", desc = "Toggle Relativenumber" },
--   { "<Space>on", "<cmd>set number!<cr>", desc = "Toggle Line Number" }
-- })
