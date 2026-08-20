{
  description = "Config NixOS de Noah";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Le fetch 3D que tu voulais ajouter !
    areofyl-fetch.url = "github:areofyl/fetch";
  };

  outputs = { self, nixpkgs, home-manager, areofyl-fetch, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
         home-manager.useGlobalPkgs = true;
         home-manager.useUserPackages = true;
         home-manager.extraSpecialArgs = { inherit inputs; };
         home-manager.users.noah = import ./home.nix;
        }
      ];
    };
  };
}
