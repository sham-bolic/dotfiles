{user, ...}: {
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
  };
  system.stateVersion = 6;
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2; # fast key repeat
      InitialKeyRepeat = 15; # short delay before repeat
      _HIHideMenuBar = true; # auto-hide the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv"; # list view by default
    finder.CreateDesktop = false; # clean desktop
    trackpad.Clicking = true; # tap to click
  };
  nix-homebrew = {
    enable = true;
    inherit user;
    autoMigrate = true; # adopt the pre-existing /opt/homebrew install, keep its packages
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # remove anything not listed here
    onActivation.autoUpdate = true;
    onActivation.extraFlags = ["--force"];
    brews = [
      "nvm"
      "pi-coding-agent"
    ];
    casks = [
      "zed"
      "codex"
      "chatgpt"
      "raycast"
      "willow-voice"
      "brave-browser"
    ];
  };

  # Homebrew's openssl@3 post-install step normally creates this link. Restore
  # it after Nix-managed Homebrew activation so Node can find its trusted CAs.
  system.activationScripts.postActivation.text = ''
    ca_bundle=/opt/homebrew/etc/ca-certificates/cert.pem
    openssl_ca_bundle=/opt/homebrew/etc/openssl@3/cert.pem
    if [ -f "$ca_bundle" ]; then
      /bin/ln -sfn ../ca-certificates/cert.pem "$openssl_ca_bundle"
    fi
  '';
}
