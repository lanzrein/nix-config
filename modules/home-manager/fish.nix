{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      export GPG_TTY=$(tty)
    '';
    plugins = [
      {
        name = "fish-you-should-use";
        src = pkgs.fishPlugins.fish-you-should-use.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      # {
      #   name = "git-abbr";
      #   src = pkgs.fishPlugins.git-abbr.src;
      # }
      # I like the one from zsh better :X
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      # Erase errors from history
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
    ];
    shellInitLast = ''
      source ~/.config/nix/nix-darwin/modules/home-manager/.iterm2_shell_integration.fish
    '';

    shellAbbrs = {
      tfmt = "terraform fmt -recursive";
      exargs = "export \$(cat .env | xargs)";
      proxy_aws = "HTTPS_PROXY=$(cat ${config.sops.templates.proxy_address_vpn.path}) aws";
      proxy_k9s = "HTTPS_PROXY=$(cat ${config.sops.templates.proxy_address_vpn.path}) k9s";
    };

    functions = {
      enable_proxy = {
        body = ''
          networksetup -setautoproxyurl 'Wi-Fi' $(cat ${config.sops.templates.proxy_pac_vpn.path})
          networksetup -setautoproxystate 'Wi-Fi' on
        '';
        description = "Enable proxy for skywalker";
      };
      disable_proxy = {
        body = ''
          networksetup -setautoproxystate 'Wi-Fi' off
        '';
        description = "Disable proxy for skywalker";
      };
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      loadenv = {
        body = lib.readFile ./data/functions/loadenv.fish;
      };
    };
  };
}
