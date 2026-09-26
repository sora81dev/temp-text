{
  description = "Tauri development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          pkg-config
          wrapGAppsHook4

          cargo
          cargo-tauri
          nodejs
          rustc

          gst_all_1.gst-plugins-base
        ];

        buildInputs = with pkgs; [
          librsvg
          webkitgtk_4_1
        ];

        shellHook = ''
          export XDG_DATA_DIRS="$GSETTINGS_SCHEMAS_PATH"
        '';
      };
    };
}
