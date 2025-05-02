{
  root,
  pkgs,
}:
root.lib.wrap rec {
  basePackage = pkgs.btop;
  env.XDG_CONFIG_HOME.value = "${placeholder "out"}/share/.config";
  postBuild = ''
    mkdir -p ${env.XDG_CONFIG_HOME.value}/btop/themes
    cp ${./btop.conf} ${env.XDG_CONFIG_HOME.value}/btop/btop.conf
    cp ${./catppuccin-frappe.theme} ${env.XDG_CONFIG_HOME.value}/btop/themes/catppuccin-frappe.theme
  '';
}
