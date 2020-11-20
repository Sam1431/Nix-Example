# https://nixos.wiki/wiki/Home_Manager

# Stuff on this file, and ./*.nix, should work across all of my computing
# devices. Presently these are: Thinkpad, Macbook and Pixel Slate.

{ config, pkgs, hostName, lib, ...}:

let
  colorscheme = (import ./cfg/colorschemes/onedark.nix); # Colorscheme ( used in xmonad [old] )
in
{
  programs.home-manager.enable = true;
  
  nixpkgs.config.allowUnfree = true;
  #home.file.".config/nixpkgs/config.nix".text = ''
  # { allowUnfree = true; }

# Some Useful packages

home.packages = with pkgs; [
    # TUI
    htop
    tree 
    unzip
    wget
    youtube-dl
    exa
    ripgrep
    neofetch
    ranger
    trash-cli
    cmatrix
    ghc
    # GUI
    firefox
    zathura
    feh
    paper-icon-theme
    lxappearance
    pavucontrol
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  ################################################## Git Cfg #######################################################

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = " < your github username > ";
    userEmail = " < your email > ";
    aliases = {
      co = "checkout";
      ci = "commit";
      s = "status";
      st = "status";
    };
    extraConfig = {
      core.editor = "nvim";
      protocol.keybase.allow = "always";
      credential.helper = "store --file ~/.git-credentials";
      pull.rebase = "false";
    };
  };

  ################################################ Neovim Cfg ######################################################

    programs.neovim = {
      enable = true;
      vimAlias = true;
      extraConfig = builtins.readFile ./cfg/Vim.vim;

      # Plugins for Vim

      plugins = with pkgs.vimPlugins; [
        # Syntax / Language Support ##########################
        vim-nix
        # vim-ruby # ruby
        # vim-go # go
        # vim-fish # fish
        # vim-toml           # toml
        # vim-gvpr           # gvpr
        # rust-vim # rust
        # vim-pandoc # pandoc (1/2)
        # vim-pandoc-syntax # pandoc (2/2)
        # yajs.vim           # JS syntax
        # es.next.syntax.vim # ES7 syntax
        goyo-vim
        vim-startify
        # UI #################################################
        dracula-vim # colorscheme
        vim-gitgutter # status in gutter
        vim-devicons
        vim-airline
        vim-airline-themes
        # Editor Features ####################################
        # vim-surround # cs"'
        # vim-repeat # cs"'...
        # vim-commentary # gcap
        # vim-ripgrep
        # vim-indent-object # >aI
        # vim-easy-align # vipga
        # vim-eunuch # :Rename foo.rb
        # vim-sneak
        # supertab
        # vim-endwise        # add end, } after opening block
        # gitv
        # tabnine-vim
        # ale # linting
        nerdtree
        # vim-toggle-quickfix
        # neosnippet.vim
        neosnippet-snippets
        # splitjoin.vim
        nerdtree

        # Buffer / Pane / File Management ####################
        fzf-vim # all the things

        # Panes / Larger features ############################
        tagbar # <leader>5
        vim-fugitive # Gblame
      ];
    };

  ############################################# Alacritty Cfg ######################################################

  # Everything you need to be blazing fast

  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ../../.config/nixpkgs/cfg/alacritty.nix) {
    };
  };

  ############################################## Rofi Cfg ##########################################################

  # Not a dmenu replacement

  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override {
      plugins = [ pkgs.rofi-emoji pkgs.rofi-calc pkgs.rofi-file-browser ];
    };
  };

  # Just symlinks

  home.file.".config/rofi/appmenu".source = ./cfg/rofi/appmenu;         # Appmenu
  home.file.".config/rofi/theme".source = ./cfg/rofi/theme;             # Required themes
  home.file.".config/rofi/powermenu".source = ./cfg/rofi/powermenu;     # Powermenu
  home.file.".config/rofi/windowmenu".source = ./cfg/rofi/windowmenu;   # Windowmenu
  home.file.".config/rofi/config.rasi".source = ./cfg/rofi/config.rasi; # Rofi main config

################################################ Xmonad Cfg ########################################################
#
# Uncomment If you want a xmonad desktop to start with
#
#  xsession = {
#    enable = true;
#    scriptPath = ".hm-xsession";
#    windowManager.xmonad = {
#      enable = true;
#      enableContribAndExtras = true;
#      config = pkgs.writeText "xmonad.hs" ''
#        ${builtins.readFile ./cfg/xmonad/config.hs}
#
#        myFocusedBorderColor = "${colorscheme.accent-primary}"
#        myNormalBorderColor = "${colorscheme.bg-primary-bright}"
#      '';
#    };
#  };
#
############################################# Nu Shell Oh,Yeah ####################################################

  # Shell for the github Era ( Written in rust )

  programs.nushell = {
    enable = true;
    settings = {
      skip_welcome_message = true;
      edit_mode = "vi";
      prompt = "echo $(starship prompt)"; # Enable the Starship prompt
    };
  };
  ############################################ STARSHIP PROMPT. ####################################################

  # Arrow like prompt based on rust

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false; # Disable the vertical gap
    };
  };

  ############################################# Compositing ########################################################

  # Its Vim , just in a browser

  programs.qutebrowser = {
    enable = true;
    extraConfig = builtins.readFile ./cfg/qutebrowser/config.py;
  };

    home.file.".config/qutebrowser/dracula".source = ./cfg/qutebrowser/dracula; # Symlink for dracula qutebrowser theme

  ############################################# Compositing ########################################################

  # A compositor to prevent screen tearing and get some fancy effects

   services.picom = {
   enable = true;
   package = pkgs.callPackage ./cfg/picom-tryone.nix { };
   experimentalBackends = true;

      ### Fading effects ###

   fade = true;
   fadeDelta = 2;

      ### Shadow Rules ###

   shadow = true;
   shadowOffsets = [ (-7) (-7) ];
   shadowOpacity = "0.7";
   shadowExclude = [ "name = 'Notification'" "class_g = 'Rofi'" ];
   noDockShadow = false;
   noDNDShadow = true;

      ### Opacity Rules ###

   activeOpacity = "1.0";
   inactiveOpacity = "0.8";
   opacityRule = [ "80:name *?= 'xmobar'" "80:name *?= 'shellPrompt'" ];
   menuOpacity = "0.8";
   backend = "glx";
   vSync = true;

      ### Some other straight-forward options ###

   extraOptions = ''
     shadow-radius = 7;
     clear-shadow = true;
     frame-opacity = 0.7;
     blur-method = "dual_kawase";
     blur-strength = 0;
     alpha-step = 0.06;
     detect-client-opacity = true;
     detect-rounded-corners = true;
     paint-on-overlay = true;
     detect-transient = true;
     mark-wmwin-focused = true;
     mark-ovredir-focused = true;
   '';
  };


  ################################################## Emacs #########################################################

  # A Editor that is so bad that it has everything except a good editor
  
  programs.emacs = {
    enable = true;
  };
  
  ################################################# THE End #############################################
}

