{ inputs, outputs, lib, config, pkgs, vars, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

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
      "usbcore.autosuspend=-1"
      "nvme.noacpi=1"
      "amd_pstate=guided"
      "mem_sleep_default=deep"
      "amdgpu"
      "amdgpu.sg_display=0"
      "amdgpu.abmlevel=3"
    ];
    blacklistedKernelModules = [ "hid_logitech_hidpp" ];
  };

  networking = {
    hostName = "framework";
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1 local.app.castmagic.io
    '';
  };

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
      enable = true;
      xkb.layout = "gb";
      xkb.variant = "";
      autoRepeatDelay = 250;
      autoRepeatInterval = 30;
      exportConfiguration = true;
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "where_is_my_sddm_theme";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    resolved.enable = true;

    # greetd = {
    #   enable = true;
    #   settings = rec {
    #     initial_session = {
    #       command = "${pkgs.hyprland}/bin/Hyprland";
    #       user = "${vars.user}";
    #     };
    #     default_session = initial_session;
    #   };
    # };

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

    postgresql = {
      enable = true;
      ensureDatabases = [ "mydatabase" ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser     auth-method
        local all       all        trust
        local all       all        md5
        local all       postgres   peer
        host  all       postgres   localhost               trust
        host  all       all        127.0.0.1/32            md5
        host  all       all        ::1/128                 ident
      '';
    };

    fwupd.enable = true;
    blueman.enable = true;
    upower = {
      enable = true;
      criticalPowerAction = "Hibernate";
      ignoreLid = true;
    };
    power-profiles-daemon.enable = true;
    fprintd.enable = true;
    # from nixos-hardware/common/pc/ssd
    fstrim.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
      powerKey = "ignore";
      powerKeyLongPress = "poweroff";
    };

    # logind.extraConfig = ''
    #   HandlePowerKey=ignore
    #   powerKeyLongPress=shutdown
    #   lidSwitch=ignore
    # '';
    # logind = {
    #   # lidSwitch = "hibernate";
    #   extraConfig = ''
    #     HandlePowerKey=ignore
    #     IdleAction=hibernate
    #     IdleActionSec=2m
    #   '';
    # };
    pcscd.enable = true;
    thermald.enable = true;
    auto-cpufreq.enable = true;
    automatic-timezoned.enable = true;
    flatpak.enable = true;
  };

  # systemd.sleep.extraConfig = "HibernateDelaySec=2h";
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
    pam.services.swaylock = { };
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
    extraGroups = [ "networkmanager" "wheel" "input" "wireshark" ];
    packages = with pkgs; [ ];
    ignoreShellProgramCheck = true;
    shell = pkgs.${vars.shell};
  };

  environment = {
    systemPackages = with pkgs; [
      gcc
      git
      gnupg
      killall
      neovim
      polkit-kde-agent
      python3
      rar
      unzip
      wget
      xarchiver
      zip
    ];

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    etc = lib.mapAttrs' (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    }) config.nix.registry;

    sessionVariables.NIXOS_OZONE_WL = "1"; # VSCode
    sessionVariables.NEOVIDE_MULTIGRID = "1";
  };

  xdg.mime.defaultApplications = {
    "x-scheme-handler/http" = "google-chrome.desktop";
    "x-scheme-handler/https" = "google-chrome.desktop";
    "text/html" = "google-chrome.desktop";
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
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
      enableSSHSupport = true;
    };
  };

  # OpenCL / Vulkan
  hardware = {
    opengl = {
      enable = true;
      extraPackages = [ pkgs.rocm-opencl-icd pkgs.amdvlk ];
      driSupport = true;
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
