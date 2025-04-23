{ inputs, ... }: {
  # Import Nix modules
  imports = [
    ./wofi (import ./ags { inherit inputs; }) ./mako.nix ./wlogout.nix
  ];
}
