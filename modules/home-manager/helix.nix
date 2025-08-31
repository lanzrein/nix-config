{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {theme = "flexoki_dark";};
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
        language-servers = ["nil"];
      }

      {
        name = "rust";
        auto-format = true;
        language-servers = ["rust-analyzer"];
        roots = ["Cargo.toml" "Cargo.lock"];
      }
      {
        name = "python";
        auto-format = true;
        language-servers = ["basedpyright" "ruff"];
        roots = ["requirements.txt" "uv.lock"];
      }
    ];
  };
}
