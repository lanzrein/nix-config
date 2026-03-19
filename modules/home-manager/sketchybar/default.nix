{
  config,
  pkgs,
  ...
}: {
  home.file.".config/sketchybar".source = config.lib.file.mkOutOfStoreSymlink "/etc/nix-config/modules/home-manager/sketchybar/config";

  home.packages = [
    pkgs.sketchybar-app-font
  ];
}
