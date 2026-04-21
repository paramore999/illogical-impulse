{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      user = {
        name = "paramore999";
        email = "sacrxsanct@outlook.com";
      };
    };
  };
}
