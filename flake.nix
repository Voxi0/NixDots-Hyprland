{
	description = "NixDots Hyprland configuration";

	# Configure Hyprland binary cache to avoid recompiling a lot of packages from scratch every rebuild
	nixConfig = {
		extra-substituters = [ "https://hyprland.cachix.org" ];
		extra-trusted-public-keys = [
			"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
		];
	};

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
    };

		# Export Home Manager module
		homeManagerModules = {
			default = self.homeManagerModules.nixdots-hyprland;
			nixdots-hyprland = import ./default.nix { inherit lib inputs; };
		};
	};
}
