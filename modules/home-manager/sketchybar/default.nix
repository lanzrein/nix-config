{
  config,
  pkgs,
  ...
}: {
  home.file.".config/sketchybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/nix-darwin/modules/home-manager/sketchybar/config";

  home.packages = [
    pkgs.sketchybar-app-font
  ];
}
