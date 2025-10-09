{
  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = import ../keys.nix;
}
