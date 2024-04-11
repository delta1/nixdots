{ inputs, lib, config, pkgs, ... }: {
  imports = [ ./dconf.nix ];

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

  home.packages = with pkgs; [
    appimage-run
    atuin
    bitcoind
    dconf2nix
    gnome.dconf-editor
    gnome.gnome-tweaks
    nixfmt
    ripgrep
    #vscode
    #signal-desktop

    #libusb
    #udev
    #usbutils
    #python3
    #hwi
    #elementsd #collision test_bitcoin
  ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Byron Hambly";
    userEmail = "byron@hambly.dev";
  };
  programs.zsh = {
    enable = true;
    shellAliases = { };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
