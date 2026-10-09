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

      "server-onion" = {
        HostName = "ssh2zogrtxbiacfn2kjuzllkwzz66s5swetszbr4bv2v74ghulariaqd.onion";
        User = "user";
        IdentityFile = "/home/user/.ssh/id_ed25519";
        IdentitiesOnly = true;
        ProxyCommand = "torsocks nc %h %p";
      };

      "computer-onion" = {
        HostName = "ssh2vaulh3fglhqkdr57vjilncpemjwmjss4xjb6dbhmc3oqj7g4y4id.onion";
        User = "user";
        IdentityFile = "/home/user/.ssh/id_ed25519";
        IdentitiesOnly = true;
        ProxyCommand = "torsocks nc %h %p";
      };

      "laptop-onion" = {
        HostName = "ssh2wbruiurpbjf3qaxcyt4cgqvrmtuleydvd5wfwzetvxmhuddc2zyd.onion";
        User = "user";
        IdentityFile = "/home/user/.ssh/id_ed25519";
        IdentitiesOnly = true;
        ProxyCommand = "torsocks nc %h %p";
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
