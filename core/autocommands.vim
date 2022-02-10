" Auto-generate packer_compiled.lua file
augroup packer_user_config
	autocmd!
	autocmd BufWritePost */nvim/lua/plugins.lua source <afile> | PackerCompile
augroup end

augroup git_repo_check
  autocmd!
  autocmd VimEnter,DirChanged * call utils#Inside_git_repo()
augroup END
