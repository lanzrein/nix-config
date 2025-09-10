{pkgs, ...}: {
  services.sketchybar = {
    enable = true;

    extraPackages = [
      pkgs.jq
      pkgs.aerospace
      pkgs.sketchybar-app-font
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
  ];
}
