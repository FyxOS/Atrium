# Boots KDE Plasma - Atrium to a Plasma session and checks the distribution defaults reach
# a new user: look-and-feel, key repeat and per-screen virtual desktops.
{ pkgs, modules }:
pkgs.testers.runNixOSTest {
  name = "atrium-desktop";
  enableOCR = false;
  nodes.machine = {
    imports = modules;
    users.users.alice = {
      isNormalUser = true;
      password = "alice";
    };
    services.displayManager.autoLogin = {
      enable = true;
      user = "alice";
    };
    virtualisation.memorySize = 4096;
    virtualisation.cores = 4;
  };
  testScript = ''
    machine.wait_for_unit("display-manager.service")
    machine.wait_until_succeeds("pgrep -u alice plasmashell", timeout=300)
    machine.wait_until_succeeds("pgrep -u alice kwin_wayland", timeout=60)

    def read(file, group, key):
        return machine.succeed(
            f"su - alice -c 'kreadconfig6 --file {file} --group {group} --key {key}'"
        ).strip()

    with subtest("system-wide defaults reach a new user"):
        assert read("kdeglobals", "KDE", "LookAndFeelPackage") == "org.omnix.atrium.desktop"
        assert read("kcminputrc", "Keyboard", "RepeatDelay") == "250"
        assert read("kwinrc", "Windows", "PerOutputVirtualDesktops") == "true"

    with subtest("the Omnix base is underneath"):
        machine.succeed("test -e /usr/lib/libgtk-3.so.0")

    machine.sleep(20)
    machine.screenshot("atrium")
  '';
}
