{ config, ... }:
{
  programs.mcp = {
    enable = true;
    servers = {
      context7 = {
        command = "npx";
        args = [ "-y" "@upstash/context7-mcp" "--api-key" "{env:CONTEXT7_API_KEY}" ];
      };
      aws-docs = {
        command = "uvx";
        args = [ "awslabs.aws-documentation-mcp-server@latest" ];
        env = {
          FASTMCP_LOG_LEVEL = "ERROR";
        };
      };
      github = {
        command = "podman";
        args = [
          "run" "--rm" "-i"
          "-e" "GITHUB_PERSONAL_ACCESS_TOKEN"
          "ghcr.io/github/github-mcp-server"
        ];
        env = {
          GITHUB_PERSONAL_ACCESS_TOKEN = "{env:GH_TOKEN}";
        };
      };
      mcp-atlassian = {
        command = "podman";
        args = [
          "run" "--rm" "-i"
          "-e" "CONFLUENCE_URL"
          "-e" "CONFLUENCE_PERSONAL_TOKEN"
          "-e" "JIRA_URL"
          "-e" "JIRA_PERSONAL_TOKEN"
          "ghcr.io/sooperset/mcp-atlassian:0.11.10"
        ];
        env = {
          CONFLUENCE_URL = "{env:CONFLUENCE_URL}";
          CONFLUENCE_PERSONAL_TOKEN = "{env:CONFLUENCE_PERSONAL_TOKEN}";
          JIRA_URL = "{env:JIRA_URL}";
          JIRA_PERSONAL_TOKEN = "{env:JIRA_PERSONAL_TOKEN}";
        };
      };
    };
  };

  programs.opencode = {
    enable = true;
    web.enable = true;
    settings = {
      theme = "tokyonight";
    };
    enableMcpIntegration = true;
  };

  home.sessionVariables = {
    CONTEXT7_API_KEY = "$(cat ${config.sops.templates.CONTEXT_SEVEN_API.path})";
    CONFLUENCE_PERSONAL_TOKEN = "$(cat ${config.sops.templates.CONFLUENCE_PERSONAL_TOKEN.path})";
    CONFLUENCE_URL = "$(cat ${config.sops.templates.CONFLUENCE_URL.path})";
    JIRA_URL = "$(cat ${config.sops.templates.JIRA_URL.path})";
    JIRA_PERSONAL_TOKEN = "$(cat ${config.sops.templates.JIRA_PERSONAL_TOKEN.path})";
  };
}