{ ... }:
{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      # 300 GB OS partition — 14 days is generous but prevents unbounded growth.
      options = "--delete-older-than 14d";
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      # Deduplicate identical store paths after each build.
      auto-optimise-store = true;
    };
  };

  # Each generation uses ~150-200 MB on the boot partition.
  # 15 entries × 200 MB = 3 GB max, comfortably within the 5 GB partition.
  boot.loader.systemd-boot.configurationLimit = 15;
}
