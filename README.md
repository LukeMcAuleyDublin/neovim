To install nvim-lspconfig run the following command:

```bash
git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
```

To get a fresh start, before cloning run:

```bash
rm -rf ~/.local/state/nvim

rm -rf ~/.local/share/nvim
```

Dependencies:

Sorbet Ruby LSP:

```ruby
gem install sorbet
```

Which depends on watchman:
```bash
brew install watchman
```
