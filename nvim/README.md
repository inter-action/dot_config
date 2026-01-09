## TODO


## Setup

* install Packer
* `:Mason` - to install your fav LSP server
* `:checkhealth`


## Iterm setup

* all M-* map should be remapped to Cmd-* by using iterm `send vim keys` 


## Neovim setup

-> help doc setup

`:helptags ~/.config/nvim/doc`


## Rust Lsp

```
:MasonInstall rust-analyzer codelldb
```




## Debug Neovim

```
:checkhealth
:messages

print(vim.inspect(vim.v.argv))
```

## Official Guide
* quick reference - https://neovim.io/doc/user/quickref.html#_inserting-text
* user guide - https://neovim.io/doc/user/


## TIPS & 101s
* !! https://learnvim.irian.to/
* !! https://practical.li/neovim/reference/neovim/quickfix/

* http://vimcasts.org/categories/
* morden neovim 
    * https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f#8c31
    * https://github.com/alpha2phi/modern-neovim

* config examples
    * https://github.com/LunarVim/Neovim-from-scratch


* multiple config - https://practical.li/neovim/install/multiple-configurations/#configure-shell-alias

* insert mode
    * https://dev.to/iggredible/the-only-vim-insert-mode-cheatsheet-you-ever-needed-nk9#:~:text=You%20can%20use%20autocomplete%20feature%20in%20insert%20mode,Ctrl-p.%20Autocomplete%20is%20a%20vast%20topic%20in%20Vim.
    * https://neovim.io/doc/user/insert.html#:~:text=CTRL-X%20Enter%20CTRL-X%20mode.%20This%20is%20a%20sub-mode,Insert%20the%20character%20which%20is%20above%20the%20cursor.

```
alias astro="NVIM_APPNAME=nvim-astro nvim"
             ^ this would choose the folder name to load under `./config/<NVIM_APPNAME>`
```

* !!Neovim Power Tips: Volume 2 - https://www.youtube.com/watch?v=yMs97o_TdBU

## lua

* lua vim guide - https://github.com/glepnir/nvim-lua-guide-zh
* https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
* https://tui.ninja/neovim/customizing/user_commands/creating/

### lua lang 101
* lua index starts from 1


## Neovim Config influenced by
* ! https://github.com/nvim-lua/kickstart.nvim
* https://dev.to/craftzdog/my-neovim-setup-for-react-typescript-tailwind-css-etc-58fb
* https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/#1-download-rust-analyzer-and-codelldb-with-neovims-plugins
* configuration examples
    * https://www.lazyvim.org/configuration

