let
  computer = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF6yz8qF2AurZtWC4VuudcQV2gs2wLopanb7eEoMg8Ef";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExGxnc/NYA1zuezr5SxfM7JbuLiRbBjy5FdBpBdASSA";
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJ9vjbpG3/h/EES9UiuZxgpuySqtlw834/RhFwt4qGj";
  systems = [ computer laptop server ];
in
{
  "secrets/git-credentials.age" = {
    publicKeys = systems;
    armor = true;
  };
}
