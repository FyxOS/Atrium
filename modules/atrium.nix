# Atrium: a polished, mouse-first KDE Plasma desktop on the FyxOS base.
#
# Defaults are system-wide (/etc/xdg and a look-and-feel package), KDE's own
# mechanism for distribution defaults: every user starts with them, and
# whatever a user changes in System Settings overrides them for that user.
{ config, lib, pkgs, ... }:
let
  lookAndFeel = pkgs.runCommand "atrium-look-and-feel" { } ''
    dir=$out/share/plasma/look-and-feel/org.fyxos.atrium.desktop
    mkdir -p $dir
    cp -r ${../lookandfeel}/. $dir/
  '';
in
{
  # Desktop apps, Electron and browser downloads need the GUI libraries.
  fyx.fhs.presets.desktop = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
  security.rtkit.enable = true;
  services.printing.enable = true;
  hardware.bluetooth.enable = true;

  programs.firefox.enable = true;
  environment.systemPackages = [
    lookAndFeel
    pkgs.kdePackages.kate
    pkgs.kdePackages.kcalc
    pkgs.kdePackages.ark
    pkgs.kdePackages.spectacle
    pkgs.kdePackages.filelight
  ];

  fonts.packages = [
    pkgs.inter
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
    pkgs.nerd-fonts.jetbrains-mono
  ];

  environment.etc = {
    "xdg/kdeglobals".text = ''
      [KDE]
      LookAndFeelPackage=org.fyxos.atrium.desktop

      [General]
      font=Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1
      fixed=JetBrainsMono Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1
    '';
    # Snappy key repeat: 250 ms, then 50 a second (KWin's default is 600/25).
    "xdg/kcminputrc".text = ''
      [Keyboard]
      KeyRepeat=repeat
      RepeatDelay=250
      RepeatRate=50
    '';
    "xdg/kwinrc".text = ''
      [Desktops]
      Number=4
      Rows=1

      [Windows]
      PerOutputVirtualDesktops=true
      RollOverDesktops=false

      [Plugins]
      shakecursorEnabled=true
    '';
    "xdg/kglobalshortcutsrc".text = ''
      [kwin]
      Overview=Meta+W\tMeta+Tab,Meta+W,Toggle Overview
      Grid View=Meta+G,Meta+G,Toggle Grid View
    '';
  };
}
