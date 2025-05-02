{
  root,
  pkgs,
  inputs,
}: let
  # INFO: This is for using a custom font
  # config_toml_file =
  #   root.lib.serde.updateTOML
  #   ./config.toml
  #   {
  #     fonts.additional_dirs = [
  #       "${pkgs.nerd-fonts.iosevka-term}/share/fonts/truetype/NerdFonts/IosevkaTerm"
  #     ];
  #     fonts.family = "IosevkaTerm Nerd Font Mono";
  #   };
in
  root.lib.wrap rec {
    basePackage = inputs.rio-flake.packages."${pkgs.system}".default;
    env.RIO_CONFIG_HOME.value = "${placeholder "out"}/share/.config/rio";
    postBuild = ''
      install -Dm644 ${./config.toml} ${env.RIO_CONFIG_HOME.value}/config.toml
      install -Dm644 ${./catppuccin-frappe.toml} ${env.RIO_CONFIG_HOME.value}/themes/catppuccin-frappe.toml
    '';
  }
