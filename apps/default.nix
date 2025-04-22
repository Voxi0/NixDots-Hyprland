{ lib, config, inputs, pkgs, ... }: {
  # Import Nix modules
  imports = [
    (import ./wofi { inherit inputs lib pkgs config; })
    (import ./ags { inherit inputs lib pkgs config; })
    (import ./mako.nix { inherit inputs lib pkgs config; })
    (import ./wlogout.nix { inherit inputs lib pkgs config; })
  ];
}

