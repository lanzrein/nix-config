{
  git_name,
  git_email,
  ...
}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      ui = {paginate = "never";};
      user = {
        name = "${git_name}";
        email = "${git_email}";
      };
      ui = {
        diff-formatter = ["difft" "--color=always" "$left" "$right"];
        default-command = "st";
      };
      revsets = {log = "@ | ancestors(remote_bookmarks().., 2) | trunk()";};
      git = {
        # This way i can use my pretty git config
        subprocess = true;
      };
      templates.git_push_bookmark = ''"jla/push-" ++ change_id.short()'';
      fix = {
        tools = {
          python = {
            command = ["python" "-m black"];
            patterns = ["**/*.py"];
          };
        };
      };
      signing = {
        behavior = "own";
        backend = "gpg";
        key = "DB1F073F6A32E0638BF16476092F4D66D66D18B7";
      };
    };
  };

  programs.fish = {
    shellAbbrs = {
      jjla = "jj log -r '@ | ancestors(remote_bookmarks()::, 2) | trunk()::'";
      jjb = "jj log -r 'heads(all())'";
      jjm = "jj log -r '@ | trunk()::'";
      jjpr = "jj git push -r @";
      jjpc = "jj git push -c @";
      jjf = "jj git fetch";
      jjrb = "jj rebase";
      jjrbm = "jj rebase -d main@origin";
    };
  };
}
