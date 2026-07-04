{ ... }:

{
  programs.zsh = {
    enable = true;

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreAllDups = true;
      share = true;
    };

    shellAliases = {
      lst = "ls -ltr --color=auto";
      l = "ls -ltr --color=auto";
      la = "ls -la --color=auto";
      ll = "ls -l --color=auto";
      so = "source";
      vim = "nvim";
      vz = "nvim ~/.zshrc";
      c = "cdr";
      cp = "cp -i";
      rm = "rm -i";
      mkdir = "mkdir -p";
      ".." = "c ../";
      back = "pushd";
      diff = "diff -U1";
      gs = "switch_git_branch";
      zmv = "noglob zmv -W";
    };

    shellGlobalAliases = {
      L = "| less";
      H = "| head";
      G = "| grep";
      GI = "| grep -ri";
    };

    sessionVariables = {
      VOLTA_HOME = "$HOME/.volta";
      GOOGLE_CLOUD_PROJECT = "central-mission-464403-r9";
      JAVA_HOME = "/usr/lib/jvm/java-21-openjdk";
      PNPM_HOME = "$HOME/.local/share/pnpm";
    };

    initExtraFirst = ''
      setopt IGNOREEOF
      bindkey -e
    '';

    initExtra = ''
      # PATH (mise, volta, etc.)
      export PATH="$VOLTA_HOME/bin:$PATH"
      export PATH="$PATH:/opt/nvim/"
      export PATH="$HOME/.moon/bin:$PATH"
      export PATH="/home/kshiva/.amp/bin:$PATH"
      export PATH="/home/kshiva/.opencode/bin:$PATH"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      # zsh options
      setopt auto_cd
      setopt auto_pushd
      setopt pushd_ignore_dups
      setopt correct
      setopt no_flow_control

      # keybindings
      stty erase '^?'
      bindkey "^[[3~" delete-char

      cdpath=(~)

      # word style
      autoload -Uz select-word-style
      select-word-style default
      zstyle ':zle:*' word-chars "_-./;@"
      zstyle ':zle:*' word-style unspecified

      # completion
      zstyle ':completion:*:default' menu select=2
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      # history search
      autoload -Uz history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "^p" history-beginning-search-backward-end
      bindkey "^b" history-beginning-search-forward-end

      # cdr
      autoload -Uz add-zsh-hook
      autoload -Uz chpwd_recent_dirs cdr
      add-zsh-hook chpwd chpwd_recent_dirs
      zstyle ":chpwd:*" recent-dirs-default true

      autoload -Uz zmv

      # functions
      function mkcd() {
        if [[ -d $1 ]]; then
          echo "$1 already exists!"
          cd $1
        else
          mkdir -p $1 && cd $1
        fi
      }

      # ghq + fzf
      cd_git_repo() {
        local selected="$(ghq list | fzf)"
        if [[ -n "$selected" ]]; then
          cd "$(ghq root)/$selected"
        fi
      }
      bindkey -s '^g' 'cd_git_repo\n'

      # git switch + fzf
      switch_git_branch() {
        local branches branch
        branches=$(git branch -a | sed 's/^\*//g' | sed 's/remotes\/origin\///g' | sort | uniq) && \
        branch=$(echo "$branches" | fzf --height 40% --reverse) && \
        git switch $(echo $branch | sed 's/.* //')
      }

      # history + fzf
      history_search() {
        local cmd
        cmd=$(history 1 | fzf | awk '{print substr($0, index($0,$2))}')
        [ -n "$cmd" ] && eval "$cmd"
      }
      bindkey -s '^r' 'history_search\n'

      # gtr / worktree helpers
      work() {
        local branch="$1"
        local mode="''${2:-both}"
        git gtr go "$branch" &>/dev/null || git gtr new "$branch"
        case "$mode" in
          both)   git gtr editor "$branch"; git gtr ai "$branch" ;;
          ai)     git gtr ai "$branch" ;;
          editor) git gtr editor "$branch" ;;
        esac
      }
      wtcd() { cd "$(git gtr go "$1")"; }

      # secret env
      if [ -f ~/.zshrc_secret ]; then
        source ~/.zshrc_secret
      fi

      # mise
      if type mise &>/dev/null; then
        eval "$(mise activate zsh)"
      fi

      [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

      autoload -U compinit
      compinit
    '';
  };
}
