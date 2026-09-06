{pkgs}:
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
  if pkgs.stdenv.hostPlatform.isDarwin
  then let
    macOsBin = path: name: pkgs.writeShellScriptBin name ''${path}/${name} "$@"'';
  in {
    # Grab miscelaneous macos utilities that aren't available in nixpkgs
    sudo = macOsBin "/usr/bin" "sudo";
    pbpaste = macOsBin "/usr/bin" "pbpaste";
    pbcopy = macOsBin "/usr/bin" "pbcopy";
    open = macOsBin "/usr/bin" "open";
    osascript = macOsBin "/usr/bin" "osascript";
    security = macOsBin "/usr/bin" "security";
    defaults = macOsBin "/usr/bin" "defaults";
    plutil = macOsBin "/usr/bin" "plutil";
    killall = macOsBin "/usr/bin" "killall";
    launchctl = macOsBin "/bin" "launchctl";
    caffeinate = macOsBin "/usr/bin" "caffeinate";
    mdfind = macOsBin "/usr/bin" "mdfind";
    afplay = macOsBin "/usr/bin" "afplay";
    say = macOsBin "/usr/bin" "say";

    # Better audio panel
    # soundsource = pkgs.soundsource;
  }
  else {
    sudo = pkgs.sudo-rs;
  }
)
# i.asciinema-flake.packages."${system}".default #TODO: Doesn't work for some reason
# i.asciinema-gif-generator-flake.packages."${system}".default #TODO: Doesn't work for some reason

