{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    home-manager = {
	    url = "github:nix-community/home-manager/release-25.11";
	    inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
	    url = "github:0xc000022070/zen-browser-flake";
	    inputs.nixpkgs.follows = "nixpkgs";
	    inputs.home-manager.follows = "home-manager";
    };

  };
  outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, ... }: { 
    nixosConfigurations = nixpkgs.lib.foldl' (configs: hostname:
      configs // {
        "${hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit hostname; };
          modules = [ 
	          ./host/${hostname}/configuration.nix
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
