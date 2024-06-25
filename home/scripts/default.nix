{ pkgs, ... }:
{
  # https://www.youtube.com/watch?v=qRE6kf30u4g
  home.packages = [
    (pkgs.writeShellScriptBin "myScript" ''
      echo "Hello World"
      ls --all --color=auto
    '')
  ];
}
