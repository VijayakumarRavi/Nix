{
  pkgs,
  config,
  ...
}:
{
  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file.".config/nvim/lua" = {
    source = ./lua;
    # copy the scripts directory recursively
    recursive = true;
  };
  home.file.".config/nvim/after" = {
    source = ./after;
    # copy the scripts directory recursively
    recursive = true;
  };
}
