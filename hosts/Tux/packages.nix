{ config, pkgs, ... }:
{

# List packages installed in system profile. To search, run:
# $ nix search wget
    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        micro
        tmux
        htop
        git
    ];
    fonts.fontDir.enable = true;
    fonts.fonts = with pkgs; [  
        nerdfonts
        font-awesome
        google-fonts
    ];
}
