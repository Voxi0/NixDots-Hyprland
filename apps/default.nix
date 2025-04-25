{ inputs, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./mako.nix ./wlogout.nix
  ];
}
