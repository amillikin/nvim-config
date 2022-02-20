local action_layout = require("telescope.actions.layout")

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    dynamic_preview_title = true,
    mappings = {
      n = {
        ["<M-p>"] = action_layout.toggle_preview
      },
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        ["<M-p>"] = action_layout.toggle_preview
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

require('telescope').load_extension('neoclip')

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>Telescope<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>Telescope neoclip<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tk", "<cmd>Telescope keymaps<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>Telescope colorscheme<CR>", { noremap = true, silent = true })
