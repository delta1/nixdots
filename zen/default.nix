{ inputs, lib, pkgs, ... }: {
  imports = [ 
    ./nixos/configuration.nix 
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { byron = import ./home-manager/home.nix; };
  };

  # common
  environment.shells = [ pkgs.zsh ];
  environment.variables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    firefox
    git
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.zsh.enable = true;
  services.xserver.xkbOptions = "caps:escape";
  services.xserver.excludePackages = [ pkgs.xterm ];
  users.defaultUserShell = pkgs.zsh;

  # overrides for configuration.nix
  networking.hostName = lib.mkForce "zen";
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/19f4e0e4-0fb8-474f-9e00-4c9a68b52fe1";
    fsType = "ext4";
  };

  # overrides for

}
