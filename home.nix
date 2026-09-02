{
  config,
  pkgs,
  user,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in {
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # cli i use constantly
    ripgrep # fast search
    jq # json on the command line
    gh # github cli
    pnpm # fast, disk-efficient node package manager
    # the font everything renders in
    nerd-fonts.hack
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables.EDITOR = "zed --wait";
  home.sessionVariables.NVM_DIR = "$HOME/.nvm";
  home.activation.createNvmDirectory = config.lib.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p "$HOME/.nvm"
  '';
  home.activation.installDefaultNode = config.lib.dag.entryAfter ["createNvmDirectory"] ''
    $DRY_RUN_CMD /bin/zsh -c '
      export NVM_DIR="$HOME/.nvm"
      source /opt/homebrew/opt/nvm/nvm.sh
      if ! nvm version default >/dev/null 2>&1; then
        nvm install --lts
        nvm alias default "lts/*"
      fi
    '
  '';
  # eza's default blue is too dark in the Rose Pine terminal palette.
  home.sessionVariables.EZA_COLORS = "di=1;96";

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true; # ghost text from history
    syntaxHighlighting.enable = true; # commands turn green when valid
    initContent = ''
      bindkey '^f' autosuggest-accept
      [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
    '';
    shellAliases = {
      ".." = "cd ..";
      add = "git add .";
      push = "git push";
      pull = "git pull";
      m = "git switch main";
      co = "codex";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "never";
    git = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file.".config/zed/settings.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/zed/settings.json";
    force = true;
  };
  home.file.".config/zed/keymap.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/zed/keymap.json";
    force = true;
  };
  home.file.".codex/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".pi/agent/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".pi/agent/settings.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.pi/agent/settings.json";
    force = true;
  };
  home.file.".pi/agent/models.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.pi/agent/models.json";
  home.file.".pi/agent/extensions".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.pi/agent/extensions";
  home.file.".pi/agent/themes".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.pi/agent/themes";
  home.file.".config/opencode/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";

  # Agent skills are vendored in the repo so they remain reproducible.
  home.file.".agents/skills".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.agents/skills";
}
