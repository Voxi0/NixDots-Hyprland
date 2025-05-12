{
	description = "NixDots Hyprland configuration";

	# Dependencies
	inputs = {
		# Hyprland
		hyprland.url = "github:hyprwm/Hyprland";
		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};

		# AGS - Widget library
		ags.url = "github:aylur/ags";
	};

	# Actions to be performed after all dependencies are fetched
	outputs = { self, nixpkgs, ... }@inputs: {
		# Export NixOS module for NixOS specific configuration
		nixosModules.default = { config, pkgs, lib, ... }: {
			# NVidia specific
			boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

			# Hyprland NixOS module - Required as it enables critical components needed to run Hyprland properly
			programs.hyprland = {
				enable = true;
				withUWSM = true;
				package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
				portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
			};

			# XDG desktop portal
			xdg.portal = {
				enable = true;
				extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
			};
    };

		# Export Home Manager module
		homeManagerModules.default = import ./default.nix { inherit inputs; };
	};
}
