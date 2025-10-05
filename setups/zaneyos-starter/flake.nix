{
  description = "ZaneyOS starter (nvidia-laptop)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-25.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
  };

  outputs = { self, nixpkgs, home-manager, stylix, nix-flatpak, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "ol";           # EDIT ME
      host = "my-laptop";        # EDIT ME
      profile = "nvidia-laptop"; # do not change

      mkNixosConfig = gpuProfile: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username host profile; };
        modules = [
          ./profiles/${gpuProfile}
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    in {
      nixosConfigurations = {
        nvidia-laptop = mkNixosConfig "nvidia-laptop";
      };
    };
}
