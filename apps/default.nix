{ inputs }: {
  # Import Nix modules
  imports = [
    ./wofi ./ags { inherit inputs; } ./mako.nix ./wlogout.nix
  ];
}
