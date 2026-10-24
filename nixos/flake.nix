{
  description = "Nixos flake for my settings";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Prebuilt nix-index database (weekly), for comma and command-not-found
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
  let
    mkHost = systemType: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs systemType; };
      modules = [ ./nixos/hosts/${systemType}/configuration.nix ];
    };
  in {
    nixosConfigurations = {
      main = mkHost "main";
      work = mkHost "work";
    };
  };
}
