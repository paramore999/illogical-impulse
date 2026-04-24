{ ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      # Hand DNS resolution off to systemd-resolved instead of NM's internal resolver.
      dns = "systemd-resolved";
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  # Systemd-resolved for reliable DNS resolution and LLMNR/mDNS support.
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    llmnr = "true";
  };

  # mDNS for .local hostname resolution on the LAN.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
}
