{
  git_name,
  git_email,
  ...
}: {
  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.git = {
    enable = true;

    settings = {
      user.name = "${git_name}";
      user.email = "${git_email}";
      pull.rebase = "false";
    };

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

    lfs = {enable = true;};


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
