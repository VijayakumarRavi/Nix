{ config
, lib
, pkgs
, ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "VijayakumarRavi";
    userEmail = "me@vijayakumar.xyz";

    extraConfig = {
      init.defaultBranch = "master";
      init.templatedir = "~/.config/git/template";
      color.ui = "auto";
      push.autoSetupRemote = true;
      pull.rebase = true;
      commit.gpgsign = true;

      # replace https with ssh
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
        "ssh://git@gitlab.com/" = {
          insteadOf = "https://gitlab.com/";
        };
        "ssh://git@bitbucket.com/" = {
          insteadOf = "https://bitbucket.com/";
        };
      };
    };

    signing = {
      key = "D0D2B010253E07C3";
      signByDefault = true;
    };

    delta = {
      enable = true;
      options = {
        features = "side-by-side";
      };
    };

    aliases = {
      pushall = "!f(){ for i in `git remote`; do git push $i; done; };f";
      pullall = "!f(){ for i in `git remote`; do git pull $i; done; };f";
      commit = "commit -S";
      a    = "add";
      b    = "branch";
      c    = "commit -S";
      d    = "difftool";
      m    = "mergetool";
      l    = "log";
      t    = "tag";
      ai   = "add -i";
      ci   = "commit -S";
      cp   = "cherry-pick";
      cs   = "commit --signoff";
      cm   = "commit -S --amend";
      co   = "checkout";
      dc   = "difftool --cached";
      fp   = "format-patch";
      lg   = "log --graph";
      lp   = "log --graph --pretty=format:'%Cred%h%Credreset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      rb   = "rebase";
      ut   = "rm -r --cached";
      new  = "flow feature start";
      rel  = "flow release start";
      fix  = "flow hotfix start";
      undo = "reset --soft HEAD^";
      # Reset previous commit, but keep all the associated changes. Useful for avoiding nasty git merge commits.
      uncommit = "reset --soft HEAD^";
      unamend  = "reset --soft HEAD@{1}";
      abort    = "reset --hard HEAD^";
      new-end  = "flow feature finish";
      rel-end  = "flow release finish";
      fix-end  = "flow hotfix finish";
      support  = "flow support";   
      # aliases for submodule
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };
}
