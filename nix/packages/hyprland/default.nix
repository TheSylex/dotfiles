{
  root,
  pkgs,
}: root.lib.wrap {
  basePackage = pkgs.hyprland;
  pathAdd = with pkgs; [
    ashell
    (root.lib.wrap {
      basePackage = pkgs.walker;
      prependFlags = ["-c" "${./walker.toml}"];
      env.TERMINAL.value = "rio";
    })
    (root.lib.wrap {
      basePackage = pkgs.hyprlock;
      prependFlags = ["-c" "${./hyprlock.conf}"];
    })
  ];
  env.NIXOS_OZONE_WL.value = "1";
  prependFlags = ["-c" "${./hyprland.conf}"];
}

