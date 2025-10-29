{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./dconf.nix inputs.catppuccin.homeModules.catppuccin ];

  nixpkgs = {
    overlays = [
      #(final: prev: {
      #elementsd = prev.elementsd.overrideAttrs (_: { doCheck = false; });
      #})
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "byron";
    homeDirectory = "/home/byron";
  };

  home.file.".bitcoin" = {
    source = config.lib.file.mkOutOfStoreSymlink /mnt/data/bitcoin;
    recursive = true;
  };

  home.file.".background-image".source = ../../wallpapers/skull.png;

  home.packages = with pkgs; [
    bitcoind
    delta
    dconf2nix
    fzf
    dconf-editor
    gnome-tweaks
    nixfmt-rfc-style
    ripgrep
    starship
    #atuin
    #elementsd #collision test_bitcoin
    #hwi
    #libusb
    #python3
    #signal-desktop
    #udev
    #usbutils
    vscode
  ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings.user = {
      name = "Byron Hambly";
      email = "byron@hambly.dev";
    };
  };
  programs.zsh = {
    enable = true;
    shellAliases = { open = "xdg-open"; };
    oh-my-zsh = {
      enable = false;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    initContent = ''
      source "$(fzf-share)/key-bindings.zsh"
      source "$(fzf-share)/completion.zsh"
    '';
  };
  #programs.delta.enable = true;

  catppuccin.flavor = "mocha";
  catppuccin.starship.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
