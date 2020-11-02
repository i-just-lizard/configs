with import <nixpkgs> {};
neovim.override {
  configure = {
      customRC = ''
        syntax on
        filetype on
        filetype plugin indent on
        set shiftwidth=2 tabstop=2 nu expandtab
        set mouse=a
        let g:airline_powerline_fonts = 1
        colorscheme nord
        '';
        pathogen = {
          knownPlugins = vimPlugins;
          pluginNames = [
            "vim-nix"
            "airline"
            "vim-airline-themes"
            "deoplete-nvim"
            "nord-vim"
            "vim-colorschemes" ];
        };
      };
    }
