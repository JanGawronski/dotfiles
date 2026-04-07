{
  programs.ssh = {
		enable = true;
		enableDefaultConfig = false;
		matchBlocks = {
			"server" = {
				hostname = "192.168.1.70";
				user = "user";
			 	identityFile = "/home/user/.ssh/id_ed25519";
				identitiesOnly = true;
			};

      "computer" = {
        hostname = "192.168.1.50";
        user = "user";
      	identityFile = "/home/user/.ssh/id_ed25519";
				identitiesOnly = true;
      };
        
      "bastion" = {
				hostname = "bastion.ii.agh.edu.pl";
				user = "gawronsk";
				identityFile = "/home/user/.ssh/id_ed25519";
				identitiesOnly = true;
			};

			"AGH" = {
				hostname = "shell.lab.ii.agh.edu.pl";
				user = "gawronsk";
				identityFile = "/home/user/.ssh/id_ed25519";
				identitiesOnly = true;
				proxyJump = "bastion";
			};
		};
	};
}
