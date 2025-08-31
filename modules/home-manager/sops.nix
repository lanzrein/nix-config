{
  config,
  user,
  ...
}: {
  sops = {
    age.keyFile = "/Users/${user}/.age-key.txt"; # must have no password!
    # It's also possible to use a ssh key, but only when it has no password:
    #age.sshKeyPaths = [ "/home/user/path-to-ssh-key" ];
    defaultSopsFile = ./secrets/secrets.yaml;
  };
  sops.secrets.github_token = {};
  sops.secrets.gitlab_token = {};
  sops.secrets.gitlab_base_url = {};
  sops.templates.github_token.content = ''${config.sops.placeholder.github_token}'';
  sops.templates.gitlab_token.content = ''${config.sops.placeholder.gitlab_token}'';
  sops.templates.gitlab_base_url.content = ''${config.sops.placeholder.gitlab_base_url}'';
  sops.secrets.proxy_address_vpn = {};
  sops.templates.proxy_address_vpn.content = ''${config.sops.placeholder.proxy_address_vpn}'';
  sops.secrets.proxy_pac_vpn = {};
  sops.templates.proxy_pac_vpn.content = ''${config.sops.placeholder.proxy_pac_vpn}'';
}
