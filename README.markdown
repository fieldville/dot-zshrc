##### Installation

```
git clone https://github.com/fieldville/dot-zshrc.git ~/.zsh
```

##### Create symlinks

```
ln -s ~/.zsh/zshrc ~/.zshrc
(ln -s ~/.zsh/zshenv ~/.zshenv) if needed
```

##### Switch to the `~/.zsh` directory, and fetch submodules:

```
cd ~/.zsh
git submodule update --init
```
