
{
  root,
  inputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  modules = [
    ({pkgs, ...}: {
      imports =
        [ 
          (
            { config, lib, modulesPath, ... }:
            {
              imports = [
                (modulesPath + "/installer/scan/not-detected.nix")
              ];

              boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "uas" "usbhid" "sd_mod" ];
              boot.initrd.kernelModules = [ ];
              boot.kernelModules = [ "kvm-amd" ];
              boot.extraModulePackages = [ ];

              fileSystems."/" = {
                device = "/dev/disk/by-uuid/cee7ffd9-82c6-4693-bfd7-e40deb5dcadb";
                fsType = "ext4";
              };

              fileSystems."/boot" = {
                device = "/dev/disk/by-uuid/05AD-78BA";
                fsType = "vfat";
                options = [ "fmask=0077" "dmask=0077" ];
              };

              swapDevices = [
                { device = "/dev/disk/by-uuid/5e346d22-ae53-42cb-b13b-f36d4ae3bf29"; }
              ];

              hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

              hardware.graphics = {
                enable = true; 
              };
            }
            )
        ];

      nixpkgs.overlays = [ (final: prev: {
        inherit (prev.lixPackageSets.stable)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena;
      }) ];
      nix.package = pkgs.lixPackageSets.stable.lix;

      nixpkgs.hostPlatform = "x86_64-linux";

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "nixos"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;

      # Set your time zone.
      time.timeZone = "Europe/Madrid";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "es_ES.UTF-8";
        LC_IDENTIFICATION = "es_ES.UTF-8";
        LC_MEASUREMENT = "es_ES.UTF-8";
        LC_MONETARY = "es_ES.UTF-8";
        LC_NAME = "es_ES.UTF-8";
        LC_NUMERIC = "es_ES.UTF-8";
        LC_PAPER = "es_ES.UTF-8";
        LC_TELEPHONE = "es_ES.UTF-8";
        LC_TIME = "es_ES.UTF-8";
      };

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
      };

      # Enable touchpad support (enabled default in most desktopManager).

      # Define a user account. Don't forget to set a password with ‘passwd’.

      # Install firefox.
      programs.firefox.enable = true;

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      services.xserver.enable = true;

      # MY CONFIG
      nix.settings.experimental-features = "nix-command flakes pipe-operator";
      nix.optimise.automatic = true;

      programs.fish.enable = true;
      programs.fish.package = root.packages.fish;

      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };

      services.greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            user = "aitor";
            command = "hyprland";
          };
          default_session = initial_session;
        };
      };

      users.users.aitor = {
        isNormalUser = true;
        description = "Aitor";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.fish;
      };
      nix.settings.trusted-users = [ "aitor" ];

      services.openssh.enable = true;

      environment = {
        variables = {
          EDITOR = "hx";
        };
      };

      environment.systemPackages = pkgs.lib.attrValues root.packages;

      system.stateVersion = "25.11";
    })
  ];
}
