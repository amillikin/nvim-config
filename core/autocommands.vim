" Auto-generate packer_compiled.lua file
augroup packer_user_config
	autocmd!
	autocmd BufWritePost */nvim/lua/plugins.lua source <afile> | PackerCompile
augroup end

augroup git_repo_check
  autocmd!
  autocmd VimEnter,DirChanged * call utils#Inside_git_repo()
augroup END

augroup term_settings
  autocmd!
  " Do not use number and relative number for terminal inside nvim
  autocmd TermOpen * setlocal norelativenumber nonumber
  " Go to insert mode by default to start typing command
  autocmd TermOpen * startinsert
augroup END

augroup auto_create_dir
  autocmd!
  autocmd BufWritePre * lua require('utils').may_create_dir()
augroup END
