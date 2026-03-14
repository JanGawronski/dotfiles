{
  age = {
    secrets = {
      user-password.file = ./../../secrets/userpassword.age;
      root-password.file = ./../../secrets/rootpassword.age;
      git-credentials = {
        file = ./../../secrets/git-credentials.age;
        mode = "400";
        owner = "user";
        group = "users";
      };
    };
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };
}
