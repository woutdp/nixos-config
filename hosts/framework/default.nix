# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, outputs, lib, config, pkgs, vars, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars; };
    users = { ${vars.user} = import ../../home; };
  };

  nix = {
    nixPath = [ "/etc/nix/path" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = (lib.mapAttrs (_: flake: { inherit flake; }))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  };

  nixpkgs = { config = { allowUnfree = true; }; };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # https://git.exozy.me/a/zenpower3
    extraModulePackages = with config.boot.kernelPackages; [ zenpower ];

    kernelParams = [
      "quiet"
      "splash"
      "btusb.enable_autosuspend=0"
      "nvme.noacpi=1"
      "amd_pstate=active"
    ];
    blacklistedKernelModules = [ "hid_logitech_hidpp" ];
  };

  networking = {
    hostName = "framework";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  i18n = {
    defaultLocale = "en_CA.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_CA.UTF-8";
      LC_IDENTIFICATION = "en_CA.UTF-8";
      LC_MEASUREMENT = "en_CA.UTF-8";
      LC_MONETARY = "en_CA.UTF-8";
      LC_NAME = "en_CA.UTF-8";
      LC_NUMERIC = "en_CA.UTF-8";
      LC_PAPER = "en_CA.UTF-8";
      LC_TELEPHONE = "en_CA.UTF-8";
      LC_TIME = "en_CA.UTF-8";
    };
  };

  services = {
    xserver = {
      layout = "gb";
      xkbVariant = "";
      displayManager.gdm.enable = true;
      displayManager.defaultSession = "Hyprland";
      autoRepeatDelay = 250;
      autoRepeatInterval = 30;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "${vars.user}";
        };
        default_session = initial_session;
      };
    };

    # Caps lock -> ctrl
    interception-tools = {
      enable = true;
      plugins = with pkgs; [ interception-tools-plugins.caps2esc ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc -m 1 | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };

    fwupd.enable = true;
    blueman.enable = true;
    upower.enable = true;
    upower.criticalPowerAction = "Hibernate";
    fprintd.enable = true;
    # from nixos-hardware/common/pc/ssd
    fstrim.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    logind.lidSwitch = "suspend";
    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=suspend
    '';
    pcscd.enable = true;
    thermald.enable = true;
    auto-cpufreq.enable = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # auto-tune on start
  powerManagement.powertop.enable = true;

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.user} = {
    initialPassword = "password";
    isNormalUser = true;
    description = "${vars.name}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.${vars.shell};
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      gcc
      git
      gnupg
      hyprpaper
      killall
      neovim
      python3
      wget
    ];

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    etc = lib.mapAttrs' (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    }) config.nix.registry;
  };

  programs = {
    hyprland.enable = true;
    nm-applet.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    gnupg.agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSSHSupport = true;
    };
  };

  # OpenCL / Vulkan
  hardware = {
    opengl = {
      extraPackages = [ pkgs.rocm-opencl-icd pkgs.amdvlk ];
      driSupport32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
