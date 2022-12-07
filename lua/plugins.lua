local api = vim.api
local fn = vim.fn

local utils = require("utils")

-- The root dir to install all plugins. Plugins are under opt/ or start/ sub-directory.
vim.g.plugin_home = fn.stdpath("data") .. "/site/pack/packer"

--- Install packer if it has not been installed.
--- Return:
--- true: if this is a fresh install of packer
--- false: if packer has been installed
local function packer_ensure_install()
  -- Where to install packer.nvim -- the package manager (we make it opt)
  local packer_dir = vim.g.plugin_home .. "/opt/packer.nvim"

  if fn.glob(packer_dir) ~= "" then
    return false
  end

  -- Auto-install packer in case it hasn't been installed.
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})

  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)
  vim.cmd(install_cmd)

  return true
end

local fresh_install = packer_ensure_install()

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require("packer.util")

-- check if firenvim is active
local firenvim_not_active = function()
  return not vim.g.started_by_firenvim
end

packer.startup {
  function(use)
    -- it is recommened to put impatient.nvim before any other plugins
    use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}
    --Packer can manage itself
    use {"wbthomason/packer.nvim", opt = true}
    use {"onsails/lspkind-nvim", event = "VimEnter"}
    -- auto-completion engine
    use {"hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]]}
    -- nvim-cmp completion sources
    use {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
    use {"hrsh7th/cmp-path", after = "nvim-cmp"}
    use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
    use {"hrsh7th/cmp-emoji", after = "nvim-cmp"}
    use {"quangnguyen30192/cmp-nvim-ultisnips", after = {'nvim-cmp', 'ultisnips'}}
    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    use({ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] })
    -- treesitter does highlighting stuff
    use({ "nvim-treesitter/nvim-treesitter", event = 'BufEnter', run = ":TSUpdate", config = [[require('config.treesitter')]] })
    -- auto close html tags
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter"})
    -- color change for paired brackets
    use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter"})
    -- Python indent (follows the PEP8 style)
    use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })
    -- Python-related text object
    use({ "jeetsukumaran/vim-pythonsense", ft = { "python" } })
    -- Lines to show indentation level
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = 'VimEnter',
      config = [[require('config.indent-blankline')]]
    })
    -- Git command inside vim
    -- use({ "tpope/vim-fugitive", event = "User InGitRepo" })
    -- Better git log display
    -- use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })
    -- use({ "christoomey/vim-conflicted", requires = "tpope/vim-fugitive", cmd = {"Conflicted"} })
    -- use({ "kevinhwang91/nvim-bqf", event = "FileType qf", config = [[require('config.bqf')]] })
    -- Better git commit experience
    -- use({ "rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]] })
    -- Snippet engine and snippet template
    use({"SirVer/ultisnips", event = 'InsertEnter'})
    use({ "honza/vim-snippets", after = 'ultisnips'})
    -- Automatic insertion and deletion of a pair of characters
    use({ "windwp/nvim-autopairs", config = [[require('config.nvim-autopairs')]] })
    -- The missing auto-completion for cmdline!
    use({"gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]]})	
    -- Fancy statusline at bottom
    use {
      'nvim-lualine/lualine.nvim',
      event = 'VimEnter',
      config = [[require('config.statusline')]]
    }
    -- Buffer tabs
    -- use {
    --   'akinsho/bufferline.nvim',
    --   requires = 'kyazdani42/nvim-web-devicons', 
    --   config = [[require('config.bufferline')]] 
    -- }
    -- more convenient terminal handling
    use { 
      's1n7ax/nvim-terminal',
      config = [[require('config.nvim-terminal')]]
    }
    -- colorize color hexcodes and names
    use { 
      'norcalli/nvim-colorizer.lua', 
      config = [[require('config.nvim-colorizer')]]
    }
    -- register history
    use { 
      "AckslD/nvim-neoclip.lua",
      requires = {
        {'tami5/sqlite.lua', module = 'sqlite'},
        'nvim-telescope/telescope.nvim'
      },
      config = [[require('config.nvim-neoclip')]]
    }
    -- fuzzy search
    use {
        'nvim-telescope/telescope.nvim',
        config = [[require('config.telescope')]],
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- search emoji and other symbols
    use {'nvim-telescope/telescope-symbols.nvim', after = 'telescope.nvim'}
    -- Telescope searchable cheatsheet
    use { 
      'sudormrfbin/cheatsheet.nvim',
      requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      }
    }
    -- Repeat tTfF instead of ',' and ';' 22-04-11 removed, part of lightspeed
    -- use { 'rhysd/clever-f.vim'}
    -- file explorer
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('config.nvim-tree')]]
    }
    -- showing keybindings
    use {"folke/which-key.nvim",
      event = "VimEnter",
      config = function()
      vim.defer_fn(function() require('config.which-key') end, 2000)
      end
    }
    -- File search, tag search, and more
    use({ "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" })
    -- Kitty conf highlighting
    use { 'fladson/vim-kitty' }
    -- colorscheme plugins
    use { "rebelot/kanagawa.nvim", opt = true }
    -- underline word under cursor for whole buffer
    use { "yamatsum/nvim-cursorline" }
    -- Faster movement
    use {
      'ggandor/lightspeed.nvim',
      requires = { 'tpope/vim-repeat' },
      --config = [[require('config.lightspeed')]]
    }
    -- Markdown Renderer
    use { "ellisonleao/glow.nvim", branch = 'main' }
    -- Use neovim in Firefox
    use {
      'glacambre/firenvim',
      run = function() vim.fn['firenvim#install'](0) end 
    }
  end,
  config = {
    max_jobs = 16,
    compile_path = packer_util.join_paths(fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
  },
}

-- For fresh install, we need to install plugins. Otherwise, we just need to require `packer_compiled.lua`.
if fresh_install then
  -- We run packer.sync() here, because only after packer.startup, can we know which plugins to install.
  -- So plugin installation should be done after the startup process.
  packer.sync()
else
  local status, _ = pcall(require, "packer_compiled")
  if not status then
    local msg = "File packer_compiled.lua not found: run PackerSync to fix!"
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
  end
end

-- Auto-generate packer_compiled.lua file
api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*/nvim/lua/plugins.lua",
  group = api.nvim_create_augroup("packer_auto_compile", { clear = true }),
  callback = function(ctx)
    local cmd = "source " .. ctx.file
    vim.cmd(cmd)
    vim.cmd("PackerCompile")
    vim.notify("PackerCompile done!", vim.log.levels.INFO, { title = "Nvim-config" })
  end,
})
