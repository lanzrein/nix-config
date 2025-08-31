{
  config,
  pkgs,
  user,
  sops-nix,
  ...
}: {
  home = {
    shell.enableFishIntegration = true;
    packages = with pkgs; [
      # Base utils
      direnv
      shellcheck
      yq
      gnused
      gnutar
      age
      sops
      dos2unix
      jless
      coreutils
      git-agecrypt
      # network
      ipcalc
      nmap
      wireguard-tools
      # Git
      jjui
      # Kubernetes + docker
      kubectl
      kind
      kubernetes-helm
      syft
      dive # https://github.com/wagoodman/dive
      # Python
      pipx
      # Cloud
      steampipe
      # Image
      imagemagick
      # Do i need this ?
      nil
      ollama
      gum
      cilium-cli
      kubent

      # Not in homemanager
      jetbrains.pycharm-professional
      jetbrains.idea-ultimate
    ];
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "25.05";
  };
  programs = {
    # Better `cat`
    bat.enable = true;
    fzf.enable = true;
    jq.enable = true;
    eza.enable = true;
    fd.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;
    home-manager.enable = true;
    awscli.enable = true;
  };

  home.sessionPath = [
    "$HOME/git/gitlab/foundation/tooling/scripts/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];
  home.sessionVariables = {
    GITLAB_HOME = "$HOME/git/gitlab";
    SFY = "$HOME/git/github-sfy";
    AWS_PAGER = "";
    SOPS_AGE_KEY_FILE = "/Users/${user}/.age-key.txt";
  };

  # Allows unfree packages for nix-shell
  # https://nixos.org/manual/nixpkgs/stable/#idm140737322551056
  home.file = {
    "/Users/${user}/.config/nixpkgs/config.nix" = {
      text = ''
        {
          allowUnfree = true;
        }
      '';
    };
  };
}
