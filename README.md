 NixOS + Hyprland Config

Guide pas à pas pour déployer cette configuration sur une nouvelle machine ou une VM NixOS propre.

 Procédure d'installation

2. Lancer un shell temporaire avec Git
nix-shell -p git

3. Cloner le dépot
git clone https://github.com/royal-coem/nixos-config.git ~/nixos-config
cd ~/nixos-config

4. adapter le matériel
   sudo nixos-generate-config --dir /tmp
   cp /tmp/hardware-configuration.nix .

5.Aligner le nom d'utilisateur
 
Vérifie que ton identifiant Unix local correspond bien dans les fichiers suivants 

  configuration.nix : users.users.<username>
    
  home.nix : home.username = "<username>" et home.homeDirectory = "/home/<username>"

  flake.nix : home-manager.users.<username>
    
6. Déployer la configuration

Indexe les changements matériels dans Git et relance la reconstruction système :

git add .
sudo nixos-rebuild switch --flake .#nixos

7. lance hyprland
