{config
, lib
, pkgs
, ...
}:
{
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''

      '';
      shellOptions = [
        "autocd"
        "cdspell"
        "cdable_vars"
        "expand_aliases"
        "histappend"
        "checkwinsize"
      ];

      # load the alias file for work
      shellAliases = {
         # System Aliases
         rm="rm -vr";
         cp="cp -vr";
         rsync="rsync --progress";
         mv="mv -v";
         mkdir="mkdir -pv";
         SS="sudo systemctl";
         ls="exa -ah --color=auto --group-directories-first";
         ll="exa -alh --color=auto --group-directories-first";
         grep="grep --color=auto";
         h="history";
         j="jobs -l";
         which="type -a";
         du="du -kh";    # Makes a more readable output
         df="df -kTh";

         #NIX
         rebuild="sudo nixos-rebuild switch --flake  ~/git/Nix#Tux";

         # For ease of use shortcuts
         q="exit";
         ":q"="exit";
         c="clear";
         r="ranger";
         ",,"="cd -";
         ".."="cd ..";
         "..."="cd ../..";
         n="nvim";
         sn="sudo nvim";
         v="vim";
         svi="sudo vim";
         lzd="lazydocker";
         lzg="lazygit";
         pg="ping google.com";
         pv="ping vijayakumar.xyz";
         ncspotd="ncspot -d ~/.config/ncspot/DEBUG";
         helix="/home/vijay/Downloads/helix.AppImage";

         # Edit configs
         nrc="vim ~/.config/nvim/init.lua";
         vimrc="vim ~/.vimrc";
         bashrc="vim ~/.bashrc";
         i3con="vim ~/.config/i3/config";
         loadbash="source ~/.bashrc";
         notes="vim ~/.notes.txt";

         # Git
         gs="git status";
         gc="git clone --depth=1 --recursive";
         dot="/usr/bin/git --git-dir=$HOME/.local/share/dotfiles/ --work-tree=$HOME";
         addup="git add -u";
         ga="git add";
         gall="git add .";
         branch="git branch";
         checkout="git checkout";
         clone="git clone";
         commit="git cz --name cz_commitizen_emoji commit -s";
         fetch="git fetch";
         tag="git tag";
         newtag="git tag -a";

         # youtube-dl
         yta="youtube-dl --extract-audio --audio-format best";
         ytv="youtube-dl -f bestvideo+bestaudio ";
         ytap="youtube-dl --extract-audio --audio-format mp3 -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' ";
         ytvp="youtube-dl -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' ";

         # the terminal rickroll
         rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash";
      };
    };
    tmux = {
      aggressiveResize = true;
      baseIndex = 1;
      enable = true;
      terminal = "screen-256color";
      clock24 = false;
      plugins = with pkgs;
        [
          # bind is u
          # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/misc/tmux-plugins/default.nix#L269
          tmuxPlugins.fzf-tmux-url
        ];
      customPaneNavigationAndResize = true;
      escapeTime = 0;
      historyLimit = 100000000;
      keyMode = "vi";
      # shortcut = "Space";
      extraConfig = ''
        # change default meta key to same as screen
        unbind C-b
        unbind C-a
        set -g prefix `

        # form vim/tmux d/y buffer sync
        set -g focus-events

        # use a different prefix for nested
        bind-key -n C-y send-prefix

        # pane colors and display

        # create more intuitive split key combos (same as modern screen)

        unbind '"'
        unbind %

        unbind |
        bind | split-window -h -c "#{pane_current_path}"
        bind '\' split-window -h -c "#{pane_current_path}"
        bind 'C-\' split-window -h -c "#{pane_current_path}"
        unbind -
        bind - split-window -v -c "#{pane_current_path}"
        unbind _
        bind _ split-window -v -c "#{pane_current_path}"

        # open new windows in the current path
        bind c new-window -c "#{pane_current_path}"

        set-option -g detach-on-destroy off
        bind a command-prompt -p "New Session:" "new-session -A -s '%%'"
        bind -r m switch-client -n

        # add switch windows
        unbind p
        bind p previous-window

        # kill current window and all panes
        bind-key & kill-window

        # vi keys to resize
        bind C-k resize-pane -U 1
        bind C-j resize-pane -D 1
        bind C-h resize-pane -L 1
        bind C-l resize-pane -R 1

        # vi keys to navigate panes
        bind -r k select-pane -U
        bind -r j select-pane -D
        bind -r h select-pane -L
        bind -r l select-pane -R

        # avoid cursor movement messing with resize
        set -g repeat-time 200

        # colors, clock, and stuff
        setw -g clock-mode-colour cyan
        set -g base-index 1
        setw -g pane-base-index 1

        # color the pane borders nearly invisible
        # (when not using hacked tmux without them)
        set -g pane-border-style "fg=#171717"
        set -g pane-active-border-style "fg=#171717"

        # color of the window selection background
        set -g mode-style "bg=black"

        # very unique Mac bug
        if-shell "type 'reattach-to-user-namespace' >/dev/null" "set -g default-command 'reattach-to-user-namespace -l $SHELL'"

        # reload configuration
        bind -r r source-file ~/.config/tmux/tmux.conf \; display-message "config reloaded"

        set -g status-style "fg=#665c54"
        set -g status-bg default
        set -g status-position top
        set -g status-interval 1
        set -g status-left ""

        set -g status-right-length 50
        set -g status-right "#(z pomo)"
        set -g status-right '#(gitmux "#{pane_current_path}")'

        set -g message-style "fg=red"

        set -g status on

      '';
     };
  };
}
