{
  pkgs,
}:
(with pkgs; {
  inherit
    git
    jujutsu
    jjui
    less # Needed for git
    ps
    wget
    openssh
    rclone
    eza
    bat
    erdtree
    dust
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
    # gitui # FIXME: Doesn't compile in unstable
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
    nix-melt
    zk # Note taking
    wishlist # SSH list and connect
    alejandra
    ;
})
// (
  if pkgs.stdenv.isDarwin
  then {
    # Grab miscelaneous macos utilities that aren't available in nixpkgs
    sudo = pkgs.writeShellScriptBin "sudo" "/usr/bin/sudo $@";
    pbpaste = pkgs.writeShellScriptBin "pbpaste" "/usr/bin/pbpaste $@";
    pbcopy = pkgs.writeShellScriptBin "pbcopy" "/usr/bin/pbcopy $@";
    open = pkgs.writeShellScriptBin "open" "/usr/bin/open $@";
    osascript = pkgs.writeShellScriptBin "osascript" "/usr/bin/osascript $@";
    # Better audio panel
    # soundsource = pkgs.soundsource;
  }
  else {
    sudo = pkgs.sudo-rs;
  }
)
# i.asciinema-flake.packages."${system}".default #TODO: Doesn't work for some reason
# i.asciinema-gif-generator-flake.packages."${system}".default #TODO: Doesn't work for some reason

