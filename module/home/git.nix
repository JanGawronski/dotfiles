{
  programs.git = {
		enable = true;
		settings = {
			user = {
				name = "Jan Gawroński";
				email = "jangawronski04@gmail.com";
			};
			init.defaultBranch = "master";
      credential.helper = "store --file /run/agenix/git-credentials";
		};
  };
}
