return {
  'zbirenbaum/copilot.lua',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = false,
        auto_trigger = false, -- suggestions appear as you type
      },
      panel = {
        enabled = false, -- disable suggestion panel
      },
      filetypes = {
        -- you can optionally disable for some filetypes:
        -- markdown = false,
        -- help = false,
      },
    }

    -- -- Optional: disable default <Tab> mapping and define your own
    -- vim.g.copilot_no_tab_map = true
    -- -- Map your accept key (example: Alt-Enter)
    -- vim.api.nvim_set_keymap('i', '<M-CR>', 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
    -- disable default Tab mapping
  end,
}
