{ inputs, lib, config, pkgs, ... }: {
  # Import Nix modules
  imports = [
    ./wofi ./swaync.nix ./wlogout.nix
		inputs.ags.homeManagerModules.default
  ];

	options.enableAGS = lib.mkEnableOption "Enables AGS for widgets";

	# AGS configuration - For widgets and such
	programs.ags = {
		enable = true;
		configDir = null;

		# Additional packages to add to GJS's runtime
		extraPackages = with pkgs; [
			gtksourceview accountsservice
		] ++ (with inputs.ags.packages.${pkgs.system}; [
			hyprland powerprofiles battery network wireplumber mpris notifd bluetooth tray
		]);
	};
}
