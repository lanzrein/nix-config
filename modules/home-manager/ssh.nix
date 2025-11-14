{
  config,
  git_urls,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };
}
