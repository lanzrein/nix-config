{
  user,
  pkgs,
  ...
}: {
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [exts.pass-otp]);
    settings = {
      PASSWORD_STORE_DIR = "/Users/${user}/.config/password-store";
      PASSWORD_STORE_KEY = "DB1F073F6A32E0638BF16476092F4D66D66D18B7";
      PASSWORD_STORE_CLIP_TIME = "60";
    };
  };
}
