{
  config,
  pkgs,
  user,
  user_uid,
  hostname,
  ...
}: {
  # MacOS user & shell
  users = {
    knownUsers = ["${user}"];
    users."${user}" = {
      name = "${user}";
      home = "/Users/${user}";
      shell = pkgs.fish;
      uid = user_uid;
    };
  };

  # Networking
  networking = {
    computerName = "${hostname}";
    hostName = "${hostname}";
  };

  # Environment variables
  environment = {
    systemPackages = with pkgs; [
      git
      nil
      alejandra
      mas
    ];
    variables = {
      LANG = "en_GB.UTF-8";
    };
  };

  # System wide programs
  programs = {
    fish.enable = true;
  };

  # Nix Configuration
  # https://mynixos.com/nix-darwin/options/nix
  nix = {
    enable = true;
    package = pkgs.nix;

    # extraOptions = ''
    #   extra-platforms = x86_64-linux aarch64-linux x86_64-darwin aarch64-darwin
    # '';

    # # Macos Linux builder
    # linux-builder = {
    #   enable = true;
    #   ephemeral = true;
    #   maxJobs = 4;
    #   config = {
    #     virtualisation = {
    #       darwin-builder = {
    #         diskSize = 40 * 1024;
    #         memorySize = 8 * 1024;
    #       };
    #       cores = 6;
    #     };
    #   };
    # };

    settings = {
      trusted-users = ["root" "${user}"];
      experimental-features = ["nix-command" "flakes"];
      # How to pass this as a secret?
      # extra-access-token = ["github.com=xxxx"];
    };

    # Nix Store optimisation
    optimise = {automatic = true;};

    # Garbage collection
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  # System Global Configuration
  system = {
    # activationScripts.postUserActivation.text = ''
    #   # activateSettings -u will reload the settings from the database and apply
    #   # them to the current session, so we do not need to logout and login again
    #   # to make the changes take effect.
    #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    # '';
    primaryUser = "${user}";
    defaults = {
      NSGlobalDomain = {
        # Locale Configuration
        AppleMeasurementUnits = "Centimeters";
        AppleTemperatureUnit = "Celsius";
        AppleICUForce24HourTime = true;
      };
      # customize finder
      finder = {
        AppleShowAllExtensions = true; # show all file extensions
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar

        FXPreferredViewStyle = "Nlsv"; # default to list view
      };
    };

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
  };

  # Allow unfree packages for the darwin-switch rebuild
  nixpkgs = {config.allowUnfree = true;};

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;
}
