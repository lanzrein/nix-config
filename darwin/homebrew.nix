{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    global = {
      autoUpdate = true;
      brewfile = true;
    };

    # https://github.com/mas-cli/mas
    masApps = {
      # "Microsoft Excel" = 462058435;
      # "Microsoft PowerPoint" = 462062816;
    };

    # taps
    # taps = [];

    # cellar apps
    # brews = [ "mas" "bitwarden-cli" ];
    brews = [
      "podman"
    ];
    # cask apps
    casks = [
      "drawio"
      "firefox"
      "podman-desktop"
      "font-cascadia-code"
      "font-fira-code"
      "font-hack-nerd-font"
      "google-chrome"
      "iterm2"
      "jumpcut"
      "keepassxc"
      "menumeters"
      # "rancher"
      "signal"
      # "spotify"
      "visual-studio-code"
      "vlc"
      "wireshark-app"
      "kiro" # does not work somehow in packages..
      "ghostty" # not in packages for darwin x86
      "copilot-cli"
    ];
  };
}
