let
  secretNames = [
    "git-credentials"
    "ngrok"
    "playit"
    "userpassword"
    "rootpassword"
  ];

  mkSecret = name: {
    name = "secrets/${name}.age";
    value = {
      publicKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF6yz8qF2AurZtWC4VuudcQV2gs2wLopanb7eEoMg8Ef" #computer
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExGxnc/NYA1zuezr5SxfM7JbuLiRbBjy5FdBpBdASSA" #laptop
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJ9vjbpG3/h/EES9UiuZxgpuySqtlw834/RhFwt4qGj" #server
      ];
      armor = true;
    };
  };

  secrets = builtins.listToAttrs (map mkSecret secretNames);
in
secrets
