{ config, pkgs, ... }: {
  home.username = "arusi";
  home.homeDirectory = "/home/arusi";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    duckdb # For command-line SQL
    htop # For checking current computer usage
    fd # Replacement for find command
    parsec-bin # For streaming my screen via network
    asciinema # For quickly recording my screen
    bat # Better cat, should be called rat
    ripgrep # Quick search tool
    du-dust # Better du (disk usage)
    mprocs # Like tmux for long running non interactive services
    gitui # Fast git UI
    porsmo # Pomodoro timer
    wiki-tui # Command Line Wiki Search
    tldr # Simplified man pages
    tree # For printing directory listing
    watch # For observing changes on long running processes
    skim # Like fzf (runs with the sk command
    xclip # For using the clipboard in X11 systems
    vscode # Visual Studio Code
    pass # The pass command, for locally storing passwords
    neofetch # For bragging in the internet
    starship # Pretty prompts
    imagemagick # Image transformation, transform file format to another
    black # Python formatter
    dart-sass # For the premium edition of Hugo
    pipx # Install Python Packages in isolated envs
    httpie # For easily hitting http endpoint, usage: http GET endpoint
    pgcli # For connecting to Postgres, usage: pgcli -h localhost -U postgres
    fzf # Fuzzy finder for searching files, usage: find . -name "*.sql" | fzf
    lnav # for navigating log files, usage: lnav /var/log/syslog
    visidata # for visualizing sheets, usage: vd hw_200.csv
    delta # better git diff, usage: git diff | delta
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "everforest_dark";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };

  # zoxide is a smarter cd command, inspired by z and autojump.
  # It remembers which directories you use most frequently,
  # so you can "jump" to them in just a few keystrokes.
  # zoxide works on all major shells.
  #
  #   z foo              # cd into highest ranked directory matching foo
  #   z foo bar          # cd into highest ranked directory matching foo and bar
  #   z foo /            # cd into a subdirectory starting with foo
  #
  #   z ~/foo            # z also works like a regular cd command
  #   z foo/             # cd into relative path
  #   z ..               # cd one level up
  #   z -                # cd into previous directory
  #
  #   zi foo             # cd with interactive selection (using fzf)
  #
  #   z foo<SPACE><TAB>  # show interactive completions (zoxide v0.8.0+, bash 4.4+/fish/zsh only)
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  # Atuin replaces your existing shell history with a SQLite database,
  # and records additional context for your commands.
  # Additionally, it provides optional and fully encrypted
  # synchronisation of your history between machines, via an Atuin server.
  programs.zellij = { enable = true; };

  programs.rofi = { enable = true; };

  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "firefox";
    TERMINAL = "nu";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile = { "alacritty/alacritty.yml".source = ./alacritty.yml; };
}
