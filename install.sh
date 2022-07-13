mkdir -p ~/.config/
mkdir -p ~/.local/bin/
mkdir -p ~/.local/share/music
mkdir -p ~/Pictures/background ~/Pictures/Screenshot
touch ~/.local/share/music/directories
ln -s ~/git/rdconfig/.config/X11 ~/.config/X11
ln -s ~/git/rdconfig/.config/alacritty ~/.config/alacritty
ln -s ~/git/rdconfig/.config/awesome ~/.config/awesome
ln -s ~/git/rdconfig/.config/fontconfig ~/.config/fontconfig
ln -s ~/git/rdconfig/.config/mpd ~/.config/mpd
ln -s ~/git/rdconfig/.config/mpv ~/.config/mpv
ln -s ~/git/rdconfig/.config/nvim ~/.config/nvim
ln -s ~/git/rdconfig/.config/ranger ~/.config/ranger
ln -s ~/git/rdconfig/.config/sxiv ~/.config/sxiv
ln -s ~/git/rdconfig/.config/zathura ~/.config/zathura
ln -s ~/git/rdconfig/.config/emoji ~/.config/emoji
ln -s ~/git/rdconfig/.local/bin/scripts ~/.local/bin/scripts
ln -s ~/git/rdconfig/Templates ~/Templates
ln -s ~/git/rdconfig/.zshrc ~/.zshrc
ln -s ~/git/rdconfig/.tmux.conf ~/.tmux.conf
ln -s ~/git/rdconfig/.config/gtk-3.0 ~/.config/gtk-3.0
sudo cp ~/git/rdconfig/.config/gtk-3.0/gtk.css /usr/share/themes/Emacs/gtk-3.0/gtk-keys.css
