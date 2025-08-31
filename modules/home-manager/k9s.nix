{
  config,
  factory_cluster,
  ...
}: {
  programs.k9s = {
    enable = true;
    skins = {
      red = ./data/k9s/skins/red.yaml;
      dracula = ./data/k9s/skins/dracula.yaml;
      snazzy = ./data/k9s/skins/snazzy.yaml;
    };

    settings = {
      k9s = {
        liveViewAutoRefresh = false;
        screenDumpDir = "/Users/jlanzrein/Library/Application Support/k9s/screen-dumps";
        refreshRate = 2;
        maxConnRetry = 5;
        readOnly = false;
        noExitOnCtrlC = true;
        ui = {
          enableMouse = false;
          headless = false;
          logoless = false;
          crumbsless = false;
          noIcons = false;
        };
        skipLatestRevCheck = false;
        disablePodCounting = false;
        shellPod = {
          image = "busybox:1.35.0";
          namespace = "default";
          limits = {
            cpu = "100m";
            memory = "100Mi";
          };
        };
        imageScans = {
          enable = false;
          exclusions = {
            namespaces = [];
            labels = {};
          };
        };
        logger = {
          tail = 100;
          buffer = 5000;
          sinceSeconds = -1;
          fullScreenLogs = false;
          textWrap = false;
          showTime = false;
        };
        thresholds = {
          cpu = {
            critical = 90;
            warn = 70;
          };
          memory = {
            critical = 90;
            warn = 70;
          };
        };
      };
    };

    aliases = {
      aliases = {
        dp = "apps/v1/deployments";
        sec = "v1/secrets";
        jo = "batch/v1/jobs";
        cr = "rbac.authorization.k8s.io/v1/clusterroles";
        crb = "rbac.authorization.k8s.io/v1/clusterrolebindings";
        ro = "rbac.authorization.k8s.io/v1/roles";
        rb = "rbac.authorization.k8s.io/v1/rolebindings";
        np = "networking.k8s.io/v1/networkpolicies";
      };
    };
    # plugin = {
    # plugin = {
    # };
    # };
  };

  programs.fish = {
    shellAbbrs = {
      k9sprod = "KUBECONFIG=~/.kube/config-prod.yaml k9s";
      kprod = "KUBECONFIG=~/.kube/config-prod.yaml kubectl";
      k = "kubectl";
    };
  };

  # Only want a custom theme for prod
}
