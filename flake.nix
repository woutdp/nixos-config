{
  description = "Wout's Nix Config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Next LS for elixir
    next-ls.url = "github:elixir-tools/next-ls";

    # Neovim Bleeding Edge!
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-hardware,
      ...
    }:
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
    in
    {
      nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs outputs vars;
        };
        modules = [
          ./hosts/framework
          nixos-hardware.nixosModules.framework-13-7040-amd
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup2";
            };
          }
        ];
      };
    };
}
