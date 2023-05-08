

## Iterm setup

* all M-* map should be remapped to Cmd-* by using iterm `send vim keys` 


## Neovim setup

-> help doc setup

`:helptags ~/.config/nvim/doc`


-> vsnipt setup

for vsnipt to work, all the snippet files must be valid json syntax. the vscode snippets is not valid json by default.
has to do mannual correction before it can be loaded by `vsnip` neovim plugin.

```
ln -s ~/Library/Application\ Support/Code/User/snippets ~/.config/vsnip
```


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

## TIPS & 101s
* http://vimcasts.org/categories/
* morden neovim 
    * https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f#8c31
    * https://github.com/alpha2phi/modern-neovim

* config examples
    * https://github.com/LunarVim/Neovim-from-scratch


## lua

* lua vim guide - https://github.com/glepnir/nvim-lua-guide-zh
* https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/



## Neovim Config influenced by
* https://dev.to/craftzdog/my-neovim-setup-for-react-typescript-tailwind-css-etc-58fb
* https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/#1-download-rust-analyzer-and-codelldb-with-neovims-plugins
