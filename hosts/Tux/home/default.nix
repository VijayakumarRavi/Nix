{ config, pkgs, ... }:

{

  imports = [
    ./apps
   ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "vijay";
    homeDirectory = "/home/vijay";

    packages = with pkgs; [
       # archives
       zip
       unzip
       p7zip

       # utils
       ripgrep
       yq-go    # https://github.com/mikefarah/yq
       htop

       # misc
       libnotify
       xdg-utils
       graphviz
       onefetch

       # cloud native
       docker
       terraform
       docker-compose
       kubectl

       nodejs
       nodePackages.npm
       nodePackages.pnpm
       yarn
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
