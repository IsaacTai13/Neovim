-- Use :Lazy to open Lazy.nvim UI
-- :Lazy update to update plugins

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- This piece of code is a bootstrapping script that automatically installs lazy.nvim. The first time you launch Neovim, it checks if lazy.nvim exists, and if not, it clones it from GitHub.
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

-- [[Add the path to lazy.nvim at the beginning of the runtimepath]]
-- Neovim searches runtimepath in order. By adding Lazy.nvim to the front, you make sure it loads first — this avoids conflicts or not finding it.
---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({

  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter", -- Load plugins automatically after Neovim startup is completed 
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      -- require("core.plugin_config.telescope")
      local ok, err = pcall(require, "core.plugin_config.telescope")
      if not ok then
        vim.notify("Failed to load telescope config: " .. err, vim.log.levels.ERROR)
      end
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- Only load LSP when a real file is opened
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      "saghen/blink.cmp",
    },
    config = function()
      require("core.lsp.init")
    end,
  },

  -- Autocompletion
  {
    "saghen/blink.cmp",
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      "folke/lazydev.nvim",
    },
    config = function()
      require("core.plugin_config.blinkcmp")
    end
  },

  -- Autoformat: conform.nvim runs external formatters (stylua, shfmt, ...) that
  -- were installed via mason. It is the piece that actually "wakes up" stylua.
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- load in time for format-on-save
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "[F]ormat buffer",
      },
    },
    config = function()
      require("core.plugin_config.conform")
    end,
  },

  -- WhichKey
  { 
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("core.plugin_config.whichkey")
    end
  },

  -- ColorScheme
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    lazy = true, -- Not the active colorscheme (catppuccin is), so don't load at startup
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require("core.plugin_config.tokyonight_color")
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("core.plugin_config.catppuccin_color")
    end,
  },

  -- TODO Comments
  { "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false }  },

  -- Collection of various small independent plugins/modules
  {
    "echasnovski/mini.nvim",
    event = "VimEnter", -- Defer to just after startup (statusline still shows immediately)
    config = function()
      require("core.plugin_config.mini")
    end,
  },

  -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" }, -- Load once a file buffer is opened
    build = ":TSUpdate",
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    config = function()
      require("core.plugin_config.treesitter")
    end,
  },

  -- File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- Optional image support for file preview: See `# Preview Mode` for more information.
      -- {"3rd/image.nvim", opts = {}},
      -- OR use snacks.nvim's image module:
      -- "folke/snacks.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
      require("core.plugin_config.neo-tree")
    end,
  },

  -- Productivity
  {
    "ThePrimeagen/harpoon",
    keys = { -- Load on first use of any harpoon mapping
      "<leader>ma", "<leader>mr", "<leader>mc", "<leader>mm",
      "<leader>mn", "<leader>mp", "<leader>md",
      "<leader>m1", "<leader>m2", "<leader>m3", "<leader>m4",
      ",m", ",n", ",p",
    },
    config = function()
      require("core.plugin_config.harpoon")
    end,
  },

  -- Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter", -- suggestions are only needed once you start typing
    -- Also load on the normal-mode toggle maps so they work before any insert.
    -- No desc needed: the real keymaps (and there's no desc on them) live in copilot.lua.
    keys = { "<leader>ce", "<leader>cd", "<leader>ct", "<leader>cs", "<leader>cp" },
    config = function()
      require("core.plugin_config.copilot")
    end
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = 'VimEnter',
    config = function()
      require("core.plugin_config.gitsigns")
    end,
  },

  -- Quickly switch between terminals
  {
    'akinsho/toggleterm.nvim', version = "*",
    cmd = "ToggleTerm",
    keys = { "<leader>tb", "<leader>tg" }, -- Toggle term / lazygit
    config = function ()
      require("core.plugin_config.toggleterm")
    end
  },

  -- Markdown Support in nvim natively
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = "markdown", -- Only load for markdown files
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- autopair plugin support multiple character
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   config = function()
  --     require("core.plugin_config.autopair")
  --   end,
  -- },

  -- UI Enhancements
  -- { "bluz71/vim-nightfly-guicolors" },
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "fgheng/winbar.nvim" },
  -- { "mhinz/vim-startify" },

  -- Terminal
  -- { "voldikss/vim-floaterm" },

  -- Motion Plugins
  -- { "easymotion/vim-easymotion" },
  -- { "justinmk/vim-sneak" },

  -- Text Editing
  -- { "tpope/vim-surround" },
  -- { "tpope/vim-commentary" },
  -- { "jiangmiao/auto-pairs" },
  -- { "airblade/vim-gitgutter" },

  -- { "mbbill/undotree" },

  -- Git Tools
  -- { "akinsho/git-conflict.nvim" },
  -- { "sindrets/diffview.nvim" },
  -- { "NeogitOrg/neogit" },

  -- Writing
  -- { "Pocco81/true-zen.nvim" },

  -- UI Icons
  -- { "echasnovski/mini.icons" },

})
