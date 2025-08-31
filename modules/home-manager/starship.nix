{
  username,
  hostname,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$all"
      ];
      right_format = lib.concatStrings [
        "$time"
        "$aws"
        "$status"
        "$kubernetes"
        "$terraform"
        "$battery"
      ];
      scan_timeout = 30;
      character = {
        success_symbol = "➜";
        error_symbol = "➜";
      };
      directory = {
        truncate_to_repo = false;
      };

      username = {
        show_always = false;
        style_user = "bold green";
      };

      kubernetes = {
        disabled = true;
      };
      nodejs = {
        disabled = true;
      };

      package = {
        disabled = true;
      };

      time = {
        disabled = false;
        format = "at [$time]($style) ";
        style = "bold yellow";
        time_format = "%H:%M";
      };
      nix_shell = {
        disabled = false;
        format = "via [$symbol$state]($style) ";
      };

      battery = {
        disabled = false;
        full_symbol = "🌕";
        charging_symbol = "⚡️";
        unknown_symbol = "😶‍🌫️";
        empty_symbol = "🌑";
        discharging_symbol = "🌗";
        display = [
          {
            threshold = 100;
            style = "bold green";
          }
          {
            threshold = 50;
            style = "bold yellow";
          }

          {
            threshold = 10;
            style = "bold red";
          }
        ];
      };

      ruby = {
        disabled = true;
      };
      git_branch.disabled = true;
      git_metrics.disabled = true;
      git_commit.disabled = true;
      git_state.disabled = true;
      git_status.disabled = true;

      # git_status = {
      #   conflicted = "🏳";
      #   ahead = "⇡\${count}";
      #   behind = "⇣\${count}";
      #   diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
      #   up_to_date = "[✓](green)";
      #   untracked = "[~\($count\)](yellow)";
      #   stashed = "[\$\($count\)](yellow)";
      #   modified = "[m\($count\)](yellow)";
      #   staged = "[++\($count\)](green)";
      #   renamed = "[r\($count\)](orange)";
      #   deleted = "[d\($count\)](orange)";
      # };
      custom = {
        jj = {
          ignore_timeout = true;
          symbol = "🥋 ";
          description = "The current jj status";
          detect_folders = [".jj"];
          command = "jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template 'separate(\" \", change_id.shortest(4), bookmarks, \" - \", concat( if(conflict, \"💥\"), if(divergent, \"🚧\"), if(hidden, \"👻\"), if(immutable, \"🔒\"), ),)'";
          # command = "jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template 'separate(\" \", change_id.shortest(4), bookmarks, \"|\", concat( if(conflict, \"💥\"), if(divergent, \"🚧\"), if(hidden, \"👻\"), if(immutable, \"🔒\"), ), raw_escape_sequence(\"\\x1b[1;32m\") ++ if(empty, \"(empty)\"), raw_escape_sequence(\"\\x1b[1;32m\") ++ coalesce( truncate_end(29, description.first_line(), \"…\"), \"(no description set)\",) ++ raw_escape_sequence(\"\\x1b[0m\"),)'";
        };
        git_branch = {
          when = true;
          ignore_timeout = true;
          command = "jj root >/dev/null 2>&1 || starship module git_branch";
          description = "Only show git_branch if we're not in a jj repo";
        };
      };
    };
  };
}
