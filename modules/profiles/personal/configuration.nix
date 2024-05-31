{ config, pkgs, pkgs-unstable, ... }:
{
    imports =
        [ 
        ./hardware-configuration.nix
        ../../system/desktop_env/plasma5.nix
        ../../system/hardware/grub.nix
        ../../system/hardware/pipewire.nix
        ];

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# networking.interfaces.enp0s3.useDHCP = true;

    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Zurich";
    i18n.defaultLocale = "en_US.UTF-8";

    environment.sessionVariables = {
# If cursors become invisible
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
    };
    hardware = {
        opengl.enable = true;
        nvidia.modesetting.enable = true; # Most wayland compositors need this 
    };

    xdg.portal.enable = true;
    services.xserver = {
            layout = "us";
            xkbVariant = "";
    };

    services.xserver.windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
            luarocks # is the package manager for Lua modules
                luadbi-mysql # Database abstraction layer
        ];
    };

# Enable CUPS to print documents.
    services.printing.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.vebly = {
        isNormalUser = true;
        description = "vebly";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    environment.systemPackages =  
        (with pkgs; [
        awesome
        git
        wget
        acpi
        gtk3
        alacritty

    #Fonts
        font-awesome
        siji
        nerdfonts
         ])
         ++
         (with pkgs-unstable; [

         ]);

    users.defaultUserShell = pkgs.zsh;

    programs = {
        zsh = {
            enable = true;
            autosuggestions.enable = true;
            zsh-autoenv.enable = true;
            syntaxHighlighting.enable = true;
        };
        thunar.enable = true;
    };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
    services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

    system.stateVersion = "23.11"; 
        nix.settings.experimental-features = ["nix-command" "flakes"];

}
