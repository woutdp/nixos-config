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

  outputs = inputs @ { self, nixpkgs, hyprland, home-manager, ... }: 
    let
    inherit (self) outputs;
  vars = {
    user = "wout";
    name = "Wout De Puysseleir";
    email = "woutdp@gmail.com";
    location = "$HOME/.nix";
    terminal = "kitty";
    editor = "nvim";
    shell = "nushell";
  };
  in {
    nixosConfigurations = {

      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs vars;};
        modules = [
          ./hosts/nixos
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

    };
  };
}
