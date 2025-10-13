local helper = require("core.helper")
local winbar = helper.safe_require("winbar")

winbar.setup({
    enabled = true,

    show_file_path = true,
    show_symbols = true,

    colors = {
        path = "#6d8086",
        file_name = "#61afef",
        symbols = "#e5c07b",
    },

    icons = {
        file_icon_default = '',
        seperator = '>',
        editor_state = '●',
        lock_icon = '',
    },

    exclude_filetype = {
        'help',
        'startify',
        'dashboard',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
        'floaterm',
    },
})

-- try to disable winbar in floaterm
