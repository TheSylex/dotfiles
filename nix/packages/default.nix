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
    rclone
    eza
    bat
    erdtree
    du-dust
    tealdeer
    which
    ouch # No bullshit compress/decompress files
    netcat
    zoxide
    fzf # Needed for zoxide, use TV for the rest
    starship
    direnv
    atuin
    television # General purpose fuzzyfinder
    ripgrep
    onefetch
    fastfetch
    yazi
    gitui
    lazygit
    tdf # PDF Viewer
    uutils-coreutils-noprefix
    tty-share
    nushell
    rainfrog # Database management
    systemctl-tui
    hwatch # watch TUI
    presenterm # Powerpoint CLI
    ternimal # Screensaver
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
    # Grab miscelaneous macos utilities that aren't available in nixpkgs
    pbpaste = pkgs.writeShellScriptBin "pbpaste" "/usr/bin/pbpaste $@";
    pbcopy = pkgs.writeShellScriptBin "pbcopy" "/usr/bin/pbcopy $@";
    open = pkgs.writeShellScriptBin "open" "/usr/bin/open $@";
    osascript = pkgs.writeShellScriptBin "osascript" "/usr/bin/osascript $@";
    # Better audio panel
    soundsource = pkgs.soundsource;
  }
  else {}
)
# i.asciinema-flake.packages."${system}".default #TODO: Doesn't work for some reason
# i.asciinema-gif-generator-flake.packages."${system}".default #TODO: Doesn't work for some reason

