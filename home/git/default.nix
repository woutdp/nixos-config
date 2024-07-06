{ vars, ... }:

{
  imports = [ ./lazygit.nix ];

  programs.git = {
    enable = true;
    userName = "${vars.name}";
    userEmail = "${vars.email}";
    signing.key = "7BDCD7A5D3E78CD2636ACF1E3DE9371B50FEC46A";
    aliases = {
      please = "push --force-with-lease --force-if-includes";
      undo = "reset --soft HEAD^";
      wip = ''
        !git add .; git commit -nm 'WIP: This is a work in progress commit'
      '';
      unwip = ''
        !if git log -1 --pretty=%B | grep 'WIP'; then git reset HEAD~1; else echo 'No WIP commit was found'; fi
      '';
      slog = ''
        !f() { \
          git log \
            -''${1-20} \
            --graph \
            --abbrev-commit \
            --decorate \
            --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'; \
        }; f
      '';
    };
    extraConfig = {
      color = {
        ui = "auto";
      };
      core = {
        editor = "nvim";
        excludesfile = "~/.gitignore_global";
      };
      help = {
        autocorrect = 1;
      };
      rebase = {
        autosquash = true;
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      commit = {
        verbose = true;
        gpgSign = true;
      };
      diff = {
        tool = "difftastic";
        external = "difft";
      };
      difftool = {
        prompt = true;
        difftastic = {
          cmd = ''difft "$LOCAL" "$REMOTE"'';
        };
      };
      pager = {
        difftool = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      init = {
        defaultBranch = "master";
      };
    };
  };
}
