# Atrium

**A polished, mouse-first KDE Plasma desktop. A flavor for [FyxOS](https://github.com/FyxOS/FyxOS).**

Atrium is for people who like windows, a taskbar, and a mouse, and who want them done
well. It is a curated KDE Plasma 6 desktop with a clean panel, sensible shortcuts,
per-screen virtual desktops, and the apps a workstation needs. Because the FyxOS base
supplies the standard Linux library layout, prebuilt software such as Electron apps,
browsers for Playwright, AppImages and vendor tools runs without workarounds.

Pick **Atrium** in the FyxOS installer, or add it to an existing FyxOS machine flake:

```nix
inputs.flavor = {
  url = "github:FyxOS/Atrium";
  inputs.nixpkgs.follows = "nixpkgs";
  inputs.fyxos.follows = "fyxos";
};
# modules = [ fyxos.nixosModules.default flavor.nixosModules.default ... ];
```

## Principles

- **Fully declarative.** The panel, shortcuts, theme, and KWin settings are declared
  through home-manager and plasma-manager. No captured dotfiles are copied in, so a
  fresh install looks exactly like the screenshot.
- **Follows the FyxOS flavor contract.** It uses the base's nixpkgs (`nixos-unstable`),
  needs nothing built locally apart from unfree GPU drivers, and contains nothing
  personal.
- **Desktop-ready FHS.** It turns on the base's desktop library preset: GTK, WebKitGTK,
  mesa, and X11 client libraries.
- **NVIDIA-aware.** It uses nixpkgs' production driver with Wayland-friendly defaults,
  such as a larger BAR1 aperture, which requires "Above 4G Decoding" in the BIOS.

## Status

**Planning.** Atrium is being written from scratch for FyxOS. It is tested in VMs and on
spare disks, and is not yet anyone's daily driver. See the FyxOS
[roadmap](https://github.com/FyxOS/FyxOS/blob/main/docs/roadmap.md) (Phase 2).
