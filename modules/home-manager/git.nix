{
  git_name,
  git_email,
  ...
}: {
  programs.git = {
    enable = true;

    userName = "${git_name}";
    userEmail = "${git_email}";

    ignores = [
      "local"
      ".DS_STORE"
      ".envrc"
      ".helix"
      ".idea"
      ".direnv/*"
      ".direnv"
      ".vscode/*"
      "node_modules/*"
      ".venv/*"
      "!.vscode/settings.json"
      "!.vscode/tasks.json"
      "!.vscode/launch.json"
      "!.vscode/extensions.json"
      "!.vscode/*.code-snippets"
    ];
    extraConfig = {
      pull.rebase = "false";
    };

    lfs = {enable = true;};

    difftastic = {enable = true;};

    includes = [
      {
        condition = "gitdir:~/git/github-sfy/";
        contents = {
          core.sshCommand = "ssh -i ~/.ssh/github-sfy";
          commit = {
            gpgSign = true;
          };
        };
      }
    ];
  };

  programs.fish = {
    shellAbbrs = {
      glola = "git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --all";
    };
    functions = {
      gogl = "open -a Firefox.app \"$GITLAB_BASE_URL\"/\"$(pwd | cut -d'/' -f6-)\"";
      gogh = "open -a Firefox.app https://github.com/\"$(pwd | cut -d'/' -f6-)\"";
    };
  };
}
