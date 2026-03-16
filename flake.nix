{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable-small";

    home-manager = {
	    url = "github:nix-community/home-manager/master";
	    inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
	    url = "github:0xc000022070/zen-browser-flake";
	    inputs.nixpkgs.follows = "nixpkgs";
	    inputs.home-manager.follows = "home-manager";
    };

    agenix.url = "github:ryantm/agenix";
    
    ngrok.url = "github:ngrok/ngrok-nix";

    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";

    musicbot = {
      url = "github:JanGawronski/musicbot";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, agenix, ngrok, playit-nixos-module, musicbot, ... }: { 
    nixosConfigurations = nixpkgs.lib.foldl' (configs: hostname:
      configs // {
        "${hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit hostname; };
          modules = [ 
	          ./host/${hostname}/configuration.nix
            agenix.nixosModules.default
            { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
            ngrok.nixosModules.ngrok
            playit-nixos-module.nixosModules.default
	          musicbot.nixosModule
	          home-manager.nixosModules.home-manager {
		          home-manager = {
			          useGlobalPkgs = true;
			          useUserPackages = true;
			          users.user = import ./host/${hostname}/home.nix;
			          backupFileExtension = "backup";
			          extraSpecialArgs = { inherit zen-browser; };	
		          };		
	          }
          ];
        };
      }) {} (builtins.attrNames (builtins.readDir ./host));
  };
}
