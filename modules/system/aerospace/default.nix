{
  config,
  lib,
  ...
}: {
  services.aerospace = {
    enable = true;
    settings = {
      after-startup-command = [
        "exec-and-forget sketchybar"
      ];

      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "${lib.getExe config.services.sketchybar.package} --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
      ];

      gaps = {
        outer.left = 2;
        outer.bottom = 2;
        outer.top = 32;
        outer.right = 2;
      };

      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
        # See: https://nikitabobko.github.io/AeroSpace/commands#layout
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
        alt-f = "fullscreen";
        alt-shift-f = "layout floating tiling";
        # See: https://nikitabobko.github.io/AeroSpace/commands#move
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";
        # See: https://nikitabobko.github.io/AeroSpace/commands#resize
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";
        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
        alt-q = "workspace 1";
        alt-w = "workspace 2";
        alt-e = "workspace 3";
        alt-r = "workspace 4";
        alt-t = "workspace 5";
        alt-z = "workspace 6";
        alt-u = "workspace 7";
        alt-i = "workspace 8";
        alt-o = "workspace 9";
        alt-p = "workspace 10";
        # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
        alt-shift-q = "move-node-to-workspace 1";
        alt-shift-w = "move-node-to-workspace 2";
        alt-shift-e = "move-node-to-workspace 3";
        alt-shift-r = "move-node-to-workspace 4";
        alt-shift-t = "move-node-to-workspace 5";
        alt-shift-z = "move-node-to-workspace 6";
        alt-shift-u = "move-node-to-workspace 7";
        alt-shift-i = "move-node-to-workspace 8";
        alt-shift-o = "move-node-to-workspace 9";
        alt-shift-p = "move-node-to-workspace 10";
        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
        alt-tab = "workspace-back-and-forth";
        # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
        # See: https://nikitabobko.github.io/AeroSpace/commands#mode
        alt-shift-semicolon = "mode service";
      };
    };
  };
}
