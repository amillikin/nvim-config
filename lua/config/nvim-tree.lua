local nvim_tree = require("nvim-tree")

-- empty setup using defaults: add your own options
-- https://github.com/kyazdani42/nvim-tree.lua
nvim_tree.setup{
}

vim.api.nvim_set_keymap("n", "<space>s", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
