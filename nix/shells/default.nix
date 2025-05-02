{
  root,
  pkgs,
}: let
in {
  default = pkgs.mkShellNoCC {  
    # Import all packages
    packages = pkgs.lib.attrValues root.packages;
    shellHook = ''
      # For rio terminal
      export TERM=xterm-256color
      export COLORTERM=truecolor

      export EDITOR=$(which hx)

      export shell=$(which fish)
      export SHELL=$shell

      exec $SHELL
    '';
  };
}
