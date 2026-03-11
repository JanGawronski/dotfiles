{
  age = {
    secrets = {
      git-credentials = {
        file = ./../../secrets/git-credentials.age;
        mode = "700";
        owner = "user";
        group = "users";
      };
    };
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };
}
