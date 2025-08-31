{
  pkgs,
  home,
  config,
  ...
}: {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";

      prompt = "enabled";

      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
    extensions = with pkgs; [
      gh-poi
      gh-copilot
      gh-f
      gh-gei
    ];
  };

  programs.gh-dash = {
    enable = true;
  };

  home.sessionVariables = {
    GH_HOME = "$HOME/git/github-sfy";
    GH_BROWSER = "open -a /Applications/Firefox.app";
    # Not working atm see fish.nix interactiveShellInit for workaround..
    GH_TOKEN = "$(cat ${config.sops.templates.github_token.path})";
    GITLAB_TOKEN = "$(cat ${config.sops.templates.gitlab_token.path})";
    GITLAB_BASE_URL = "$(cat ${config.sops.templates.gitlab_base_url.path})";
  };
}
