{ lib, config, ... }: {
  # Module options
  options.enableMako = lib.mkEnableOption "Mako (Notification daemon)";

  # Configuration
  config = lib.mkIf config.enableMako {
    # Mako
    services.mako = {
      # Enable/Disable Mako
      enable = true;
			settings = ''
				{
					# Notification settings
					maxVisible = 3;
					layer = "overlay";
					anchor = "top-right";
					sort = "-time";

					# Icons
					icons = true;
					maxIconSize = 64;

					# Border
					borderSize = 1;
					borderRadius = 6;

        	# Icon Location
        	iconLocation = "left";

					# Mouse Button Actions
					onButtonLeft = "invoke-default-action";
					onButtonMiddle = "dismiss-all";
					onButtonRight = "dismiss";
				}
      '';
    };
  };
}
