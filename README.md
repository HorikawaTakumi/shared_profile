# shered_profile

## setup

- [HackGen console NF](https://github.com/yuru7/HackGen/releases) をインストールする
- Windows ターミナルの設定から 既定値→外観→フォントフェイスで HackGen console NF を選択
- hostname を適切なものに設定しておく

```sh
sudo hostnamectl set-hostname __hostname__
```

---

```zsh
sudo apt install zsh fzf bash-completion -y
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git@github.com:HorikawaTakumi/shered_profile.git ~/.myprofile
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
ln -s $HOME/.myprofile/.shared_profile ~/.shared_profile
cp -p ~/.myprofile/p10k_lean ~/.p10k.zsh
cp -p ~/.myprofile/custom.example ~/.myprofile/custom
sed -i '/source \$ZSH\/oh-my-zsh\.sh/s/^[^#]/# &/' ~/.zshrc
cat << 'EOF' >> ~/.zshrc
source ~/.shared_profile
if [[ -z "$OHMYZSH_LOADED" ]]; then
    export OHMYZSH_LOADED=1
    source $ZSH/oh-my-zsh.sh
fi
source ~/.p10k.zsh
EOF
source ~/.zshrc
```
