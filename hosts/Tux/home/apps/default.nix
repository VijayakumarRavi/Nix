{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./browsers.nix
    ./common.nix
    ./git.nix
    ./nvim.nix
    ./shell.nix
    ./media.nix
    ./xdg.nix
  ];
}
