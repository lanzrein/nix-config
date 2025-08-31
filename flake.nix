{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  # Flake outputs
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    sops-nix,
    ...
  }: let
    user = "jlanzrein";
    user_uid = 503;
    system = "x86_64-darwin";
    hostname = "Johans-MacBook-Pro";
    git_name = "Johan Lanzrein";
    git_email = "jlanzrein@pictet.com";
  in {
    formatter.${system} = inputs.nixpkgs.legacyPackages.${system}.alejandra;
    darwinConfigurations = import ./darwin {
      inherit (nixpkgs) lib;
      inherit
        inputs
        nixpkgs
        home-manager
        nix-darwin
        user
        user_uid
        system
        hostname
        git_name
        git_email
        sops-nix
        ;
    };
  };
}
