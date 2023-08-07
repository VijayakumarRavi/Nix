{
  description = "Your new nix config";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master"; #nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager,  ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      Tux = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/Tux

          home-manager.nixosModules.home-manager {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.vijay = import ./hosts/Tux/home; # ./hosts/Tux/home;
            };
          }
        ];
      };
      Tux-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/Tux-vm

          home-manager.nixosModules.home-manager {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.vijay = import ./hosts/Tux-vm/home; # ./hosts/Tux/home;
            };
          }
        ];
      };
    };
  };
}

