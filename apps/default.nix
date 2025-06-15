{ inputs, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./swaync.nix ./wlogout.nix
  ];
}
