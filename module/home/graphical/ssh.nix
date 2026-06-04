{
  programs.ssh = {
		enable = true;
		enableDefaultConfig = false;
		settings = {
			"server" = {
				HostName = "192.168.1.70";
				User = "user";
			 	IdentityFile = "/home/user/.ssh/id_ed25519";
				identitiesOnly = true;
			};

      "computer" = {
        HostName = "192.168.1.50";
        User = "user";
      	IdentityFile = "/home/user/.ssh/id_ed25519";
				IdentitiesOnly = true;
      };
        
      "bastion" = {
				HostName = "bastion.ii.agh.edu.pl";
				User = "gawronsk";
				IdentityFile = "/home/user/.ssh/id_ed25519";
				IdentitiesOnly = true;
			};

			"AGH" = {
				HostName = "shell.lab.ii.agh.edu.pl";
				User = "gawronsk";
				IdentityFile = "/home/user/.ssh/id_ed25519";
				IdentitiesOnly = true;
				ProxyJump = "bastion";
			};
		};
	};
}
