{
  pkgs,
  inputs,
}:
(with pkgs; {
  inherit
    git
    less # Needed for git
    ps
    wget
    openssh
    eza
    bat
    erdtree
    du-dust
    tealdeer
    which
    netcat
    fzf
    zoxide
    starship
    direnv
    onefetch
    fastfetch
    yazi
    gitui
    lazygit
    tdf # PDF Viewer
    uutils-coreutils-noprefix
    ;
})
// {
  sudo =
    if pkgs.stdenv.isDarwin
    then pkgs.darwin.sudo
    else pkgs.sudo-rs;
  nix-melt = inputs.nix-melt-flake.packages."${pkgs.system}".default;
}
// (
  if pkgs.stdenv.isDarwin
  then {
    # Grab system "clipboard" and "open" if we're on MacOS
    pbpaste = pkgs.writeShellScriptBin "pbpaste" "/usr/bin/pbpaste $@";
    pbcopy = pkgs.writeShellScriptBin "pbcopy" "/usr/bin/pbcopy $@";
    open = pkgs.writeShellScriptBin "open" "/usr/bin/open $@";
  }
  else {}
)
# i.asciinema-flake.packages."${system}".default #TODO: Doesn't work for some reason
# i.asciinema-gif-generator-flake.packages."${system}".default #TODO: Doesn't work for some reason

