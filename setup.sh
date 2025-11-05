#!/usr/bin/env bash

sudo -v # sk for admin credentials

apps=(
    bat
    bash-language-server
    curl
    docker
    entr
    fd
    git
    less
    lld
    neovim
    openssh
    pandoc
    python-pip
    ripgrep
    shellcheck
    shfmt
    translate-shell
    unzip
    zsh
)

sudo pacman -Syu "${apps[@]}" || true

# Install NordVPN

sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
/usr/bin/nordvpn set notify off

#############################
## Install Python Packages ##

Check if pip3 is installed
if type "pip3" &>/dev/null; then
    pip3 install --break-system-packages --user yt-dlp
fi

##################
## Install Docker ##

sudo groupadd docker
sudo usermod -aG docker "$USER"
newgrp docker
sudo systemctl enable docker --now
sudo systemctl restart docker
docker run hello-world

##################
## Install font ##

git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts || return
git sparse-checkout add patched-fonts/Hack
./install.sh Hack
cd "$HOME" || return
rm -rf nerd-fonts

#################
## Install fzf ##

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

####################
## Install nodejs ##

npm config set prefix "$HOME/.local"
npm i -g bash-language-server neovim

#####################
## Install VS Code ##

# Install VS Code extensions
if type "code" &>/dev/null; then
    extensions=(
        albert.tabout
        bierner.markdown-mermaid
        charliermarsh.ruff
        christian-kohler.path-intellisense
        davidanson.vscode-markdownlint
        docker.docker
        foxundermoon.shell-format
        james-yu.latex-workshop
        mads-hartmann.bash-ide-vscode
        ms-azuretools.vscode-containers
        ms-python.debugpy
        ms-python.python
        ms-python.vscode-pylance
        ms-python.vscode-python-envs
        pflannery.vscode-versionlens
        pkief.material-icon-theme
        redhat.vscode-yaml
        rogalmic.bash-debug
        rust-lang.rust-analyzer
        sumneko.lua
        tamasfe.even-better-toml
        timonwong.shellcheck
        tyriar.sort-lines
        uctakeoff.vscode-counter
        usernamehw.errorlens
        vmsynkov.colonize
        yy0931.save-as-root
        yzhang.markdown-all-in-one
    )

    for extension in "${extensions[@]}"; do
        code --install-extension "$extension"
    done

fi

###########################
## Create symbolic links ##

dotfiles_dir="$HOME/.config/dotfiles"
config_dir="$HOME/.config"

# git
ln -sfn "$dotfiles_dir/git/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$dotfiles_dir/git/.gitignore" "$HOME/.gitignore"

# i3
ln -sfn "$dotfiles_dir/i3" "$config_dir/i3"

# NeoVim
ln -sfn "$dotfiles_dir/nvim" "$config_dir/nvim"

# pip config
ln -sfn "$dotfiles_dir/pip" "$config_dir/pip"

# VS Code
ln -sfn "$dotfiles_dir/vscode/settings.json" "$config_dir/Code/User/settings.json"
ln -sfn "$dotfiles_dir/vscode/keybindings.json" "$config_dir/Code/User/keybindings.json"

# zsh
ln -sfn "$dotfiles_dir/zsh/.zshrc" "$HOME/.zshrc"

# cargo toml file
ln -sfn "$dotfiles_dir/cargo/config.toml" "$HOME/.cargo/config.toml"

# Change remote url of dotfiles
git remote set-url origin git@github.com:ndz-v/dotfiles.git
