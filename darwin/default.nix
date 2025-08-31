{
  lib,
  inputs,
  nixpkgs,
  home-manager,
  nix-darwin,
  user,
  user_uid,
  system,
  hostname,
  git_name,
  git_email,
  sops-nix,
  ...
}: {
  # MacBook Pro
  "${hostname}" = nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {inherit inputs user user_uid hostname;};
    modules = [
      # MacBook Pro Configuration
      ./configuration.nix
      ./homebrew.nix

      # Home Manager

      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit user git_name git_email;};
        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
        home-manager.backupFileExtension = ".bak";
        home-manager.users.${user} = {
          imports =
            [(import ./home.nix)]
            # ++ [ (import sops-nix.homeManagerModules.sops) ]
            ++ [(import ../modules/home-manager/sops.nix)]
            ++ [(import ../modules/home-manager/direnv.nix)]
            ++ [(import ../modules/home-manager/fish.nix)]
            ++ [(import ../modules/home-manager/ssh.nix)]
            ++ [(import ../modules/home-manager/git.nix)]
            ++ [(import ../modules/home-manager/helix.nix)]
            ++ [(import ../modules/home-manager/k9s.nix)]
            ++ [(import ../modules/home-manager/starship.nix)]
            ++ [(import ../modules/home-manager/pass.nix)]
            ++ [
              (import ../modules/home-manager/gpg.nix)
            ]
            ++ [(import ../modules/home-manager/nvim.nix)]
            ++ [(import ../modules/home-manager/scripts.nix)]
            ++ [(import ../modules/home-manager/gh.nix)]
            ++ [(import ../modules/home-manager/zed.nix)]
            ++ [(import ../modules/home-manager/ripgrep.nix)]
            ++ [(import ../modules/home-manager/sensitive.nix)]
            ++ [(import ../modules/home-manager/jj.nix)];
        };
      }
    ];
  };
}
