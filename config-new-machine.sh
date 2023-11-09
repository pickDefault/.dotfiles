sudo apt install gcc
sudo apt install fzf
sudo apt install zsh
read -p "Enter name for ssh key:" machinename
echo $machinename
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim


echo "Remember to create ssh-key on local machine and use ssh-copy-id to append it to authorized-keys on remote: ssh-copy-id -i key.pub $machinename@localhost" 
echo "Also get gitAWS private key and add it with ssh-add, then clone dotfiles"
echo "And create symlink for nvim at ~/.config/nvim"
