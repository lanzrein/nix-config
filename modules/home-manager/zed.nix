{...}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "swift"
      "nix"
      "xy-zed"
      "catppuccin"
    ];
    userSettings = {
      agent = {
        default_model = {
          provider = "copilot_chat";
          model = "claude-3-7-sonnet";
        };
        inline_alternatives = [
          {
            provider = "copilot_chat";
            model = "gpt-4o";
          }
        ];
        version = "2";
        default_view = "text_thread";
      };
      features = {
        copilot = true;
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = false;
      ui_font_size = 16;
      buffer_font_size = 16;
      languages = {
        Python = {
          format_on_save.language_server.name = "ruff";
          formatter.language_server.name = "ruff";
          language_servers = [
            "pyright"
            "ruff"
          ];
        };
      };
      terminal = {
        working_directory = "first_project_directory";
        detect_venv = {
          on = {
            directories = [
              ".venv"
              "venv"
              "env"
            ];
            activate_script = "fish";
          };
        };
      };
    };
    userKeymaps = [
      {
        context = "Editor";
        bindings = {
          cmd-shift-t = "workspace::OpenInTerminal";
        };
      }
      {
        context = "Workspace";
        bindings = {
          cmd-shift-t = "workspace::NewTerminal";
        };
      }
      {
        context = "Workspace";
        bindings = {
          shift-shift = "file_finder::Toggle";
        };
      }
    ];
  };
}
