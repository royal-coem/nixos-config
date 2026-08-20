{
  description = "Config NixOS de Noah";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Le fetch 3D que tu voulais ajouter !
    areofyl-fetch.url = "github:areofyl/fetch";
  };

  outputs = { self, nixpkgs, areofyl-fetch, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
