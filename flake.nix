{
  description = "hashpool.dev";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        site = pkgs.callPackage ./nix/site.nix { websiteSrc = self; };
        default = self.packages.${system}.site;
      };

      apps.${system}.preview = {
        type = "app";
        program = toString (pkgs.callPackage ./nix/preview.nix { });
      };
    };
}
