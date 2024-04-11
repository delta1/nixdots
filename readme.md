# nix dotfiles

`sudo nixos-rebuild switch --flake .#zen`

-- 

- format/reinstall 
- copy configuration.nix and hardware-configuration.nix from /etc/nixos to the correct directory in this repo
- `sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager`
- `sudo nix-channel --update`

caps:escape https://unix.stackexchange.com/a/639163
