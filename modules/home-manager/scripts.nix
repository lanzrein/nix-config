{
  git_user,
  git_email,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "dev-section";
      text = ''
        #!/bin/bash
        set -eou pipefail
        cat <<EOF >> README.md
        ${builtins.readFile ./templates/global/dev-section.md}

        EOF

        echo "added a dev setup section !"
      '';
    })
  ];
}
