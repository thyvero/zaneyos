Quick start (nvidia-laptop)

1) Copy this folder to target machine as ~/zaneyos

2) Edit flake.nix:
   - username = "<your-user>"
   - host = "<your-hostname>"

3) Create host folder and seed variables:
   cp -r hosts/template hosts/<your-hostname>
   $EDITOR hosts/<your-hostname>/variables.nix
   - set intelID / nvidiaID (from `lspci | grep -E "VGA|3D"`)

4) Generate hardware.nix on target:
   sudo nixos-generate-config --show-hardware-config > hosts/<your-hostname>/hardware.nix

5) Build & activate (safer boot activation):
   sudo nixos-rebuild boot --flake .#nvidia-laptop
   reboot

If you need immediate activation:
   sudo nixos-rebuild switch --flake .#nvidia-laptop

Notes:
- Root home-manager conflicts: ensure no /etc/nixos/* enables home-manager for root.
- This starter copies only required modules for Hyprland, drivers, and theming.
- To change Waybar/animations/wallpaper, edit hosts/<host>/variables.nix.
