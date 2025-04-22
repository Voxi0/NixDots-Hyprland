{ inputs }: {
  # Import Nix modules
  imports = [
    ./wofi ./mako.nix ./wlogout.nix
		(import ./ags { inherit inputs; })
  ];
}
