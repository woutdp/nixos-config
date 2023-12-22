{
  description = "Wout's Nix Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    inputs@{ self, nixpkgs, nixpkgs-unstable, hyprland, home-manager, ... }:
    let
      inherit (self) outputs;
      vars = {
        user = "wout";
        name = "Wout De Puysseleir";
        email = "woutdp@gmail.com";
        location = "$HOME/.nix";
        terminal = "kitty";
        editor = "nvim";
        shell = "fish";
      };
    in {
      nixosConfigurations = {

        framework = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs vars nixpkgs-unstable; };
          modules = [
            ./hosts/framework
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };

      };
    };
}
