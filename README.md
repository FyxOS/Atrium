# KDE Plasma - Atrium

**A polished, mouse-first KDE Plasma desktop. A flavor for [Omnix](https://github.com/Omnix-Linux/Omnix).**

KDE Plasma - Atrium is for people who like windows, a taskbar, and a mouse, and who want them done
well. It is a curated KDE Plasma 6 desktop with a clean panel, sensible shortcuts,
per-screen virtual desktops, and the apps a workstation needs. Because the Omnix base
supplies the standard Linux library layout, prebuilt software such as Electron apps,
browsers for Playwright, AppImages and vendor tools runs without workarounds.

Pick **KDE Plasma - Atrium** in the Omnix installer, or add it to an existing Omnix machine flake:

```nix
inputs.flavor = {
  url = "github:Omnix-Linux/Atrium";
  inputs.nixpkgs.follows = "nixpkgs";
  inputs.omnix.follows = "omnix";
};
# modules = [ omnix.nixosModules.default flavor.nixosModules.default ... ];
```

Desktop labels follow the [Omnix naming policy](https://github.com/Omnix-Linux/Omnix/blob/main/docs/naming.md).

## Principles

- **Fully declarative.** The panel, shortcuts, theme, and KWin settings are declared
  through home-manager and plasma-manager. No captured dotfiles are copied in, so a
  fresh install looks exactly like the screenshot.
- **Follows the Omnix flavor contract.** It uses the base's nixpkgs (`nixos-unstable`),
  needs nothing built locally apart from unfree GPU drivers, and contains nothing
  personal.
- **Desktop-ready FHS.** It turns on the base's desktop library preset: GTK, WebKitGTK,
  mesa, and X11 client libraries.
- **NVIDIA-aware.** It uses nixpkgs' production driver with Wayland-friendly defaults,
  such as a larger BAR1 aperture, which requires "Above 4G Decoding" in the BIOS.

## Status

**First version.** `nixosModules.default` is a KDE Plasma 6.7 desktop on the Omnix
base:

- KDE's own mechanism for distribution defaults, so every user starts with
  KDE Plasma - Atrium and changes in System Settings stay theirs:
  - system-wide `/etc/xdg` settings (KDE Plasma - Atrium look-and-feel, 250 ms / 50 Hz key
    repeat, per-screen virtual desktops, Overview shortcuts);
  - a look-and-feel package whose layout gives a slim top bar and a floating
    bottom dock.
- The Omnix desktop library preset, PipeWire, printing, Bluetooth, Firefox and
  fonts (Inter, Noto, JetBrains Mono Nerd).

`nix flake check` boots it in a VM. It checks that the defaults reach a new
user, and takes a screenshot.
