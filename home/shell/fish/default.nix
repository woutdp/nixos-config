{ vars, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -U grcplugin_ls --color -l

      set -U fish_color_normal normal
      set -U fish_color_command FF9400
      set -U fish_color_quote BF9C30
      set -U fish_color_redirection BF5B30
      set -U fish_color_end FF4C00
      set -U fish_color_error FFDD73
      set -U fish_color_param FFC000
      set -U fish_color_comment A63100
      set -U fish_color_match --background=brblue
      set -U fish_color_selection white --bold --background=brblack
      set -U fish_color_search_match bryellow --background=brblack
      set -U fish_color_history_current --bold
      set -U fish_color_operator 00a6b2
      set -U fish_color_escape 00a6b2
      set -U fish_color_cwd green
      set -U fish_color_cwd_root red
      set -U fish_color_valid_path --underline
      set -U fish_color_autosuggestion FFC473
      set -U fish_color_user brgreen
      set -U fish_color_host normal
      set -U fish_color_cancel --reverse
      set -U fish_pager_color_prefix normal --bold --underline
      set -U fish_pager_color_progress brwhite --background=cyan
      set -U fish_pager_color_completion normal
      set -U fish_pager_color_description B3A06D
      set -U fish_pager_color_selected_background --background=brblack
      set -U fish_color_host_remote 
      set -U fish_color_keyword 
      set -U fish_pager_color_secondary_background 
      set -U fish_color_option 
      set -U fish_pager_color_selected_description 
      set -U fish_pager_color_selected_completion 
      set -U fish_pager_color_secondary_prefix 
      set -U fish_pager_color_selected_prefix 
      set -U fish_pager_color_background 
      set -U fish_pager_color_secondary_completion 
      set -U fish_pager_color_secondary_description

      set -U ABBR_TIPS_PROMPT "\n💡 \e[1m{{ .abbr }}\e[0m => {{ .cmd }}"
      set -U ABBR_TIPS_ALIAS_WHITELIST # Not set
      set -U ABBR_TIPS_REGEXES '(^(\w+\s+)+(-{1,2})\w+)(\s\S+)' '(^( ?\w+){3}).*' '(^( ?\w+){2}).*' '(^( ?\w+){1}).*'

      set -U NIX_LD $(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')

      if command -q nix-your-shell
        nix-your-shell fish | source
      end

      if command -q thefuck
        thefuck --alias | source
      end
    '';
    plugins = with pkgs; [
      {
        name = "puffer";
        src = fishPlugins.puffer.src;
      }
      {
        name = "sponge";
        src = fishPlugins.sponge.src;
      }
      {
        name = "bass";
        src = fishPlugins.bass.src;
      }
      {
        name = "forgit";
        src = fishPlugins.forgit.src;
      }
      {
        name = "fzf-fish";
        src = fishPlugins.fzf-fish.src;
      }
      {
        name = "autopair";
        src = fishPlugins.autopair.src;
      }
      {
        name = "done";
        src = fishPlugins.done.src;
      }
      {
        name = "grc";
        src = fishPlugins.grc.src;
      }
      {
        name = "z";
        src = fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          hash = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }
    ];
    shellAbbrs = {
      c = "clear";
      g = "git";
      gc = "git commit";
      gca = "git commit --amend";
      gg = "lazygit";
      gst = "git status";
      home = "cd ~";
      ls = "ls";
      lst = "ls -T -L 2";
      ll = "ls -l";
      la = "ls -la";
      master = "git checkout master";
      staging = "git checkout staging";
    };
    shellAliases = {
      cat = "bat";
      ls = "eza --icons=always --hyperlink -F";
      l = "ls";
      dev = "nix develop -c ${vars.shell}";
      rebuild = "sudo nixos-rebuild switch --flake /home/wout/.nix";
      wifi = "nmcli dev wifi show-password";
    };
  };

  home.packages = with pkgs; [
    grc
    fzf
  ];
}
