{
  age.secrets = {
    git-credentials = {
      file = ./../../secrets/git-credentials.age;
      mode = "400";
      owner = "user";
      group = "users";
    };
  };
}
