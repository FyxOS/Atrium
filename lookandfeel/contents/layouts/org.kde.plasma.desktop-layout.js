// KDE Plasma - Atrium's first-login layout: a slim top bar and a floating bottom dock.
// Plasma runs this once per new user; anything they change afterwards is theirs.

var top = new Panel;
top.location = "top";
top.height = Math.round(gridUnit * 1.6);
top.addWidget("org.kde.plasma.kickoff");
top.addWidget("org.kde.plasma.appmenu");
top.addWidget("org.kde.plasma.panelspacer");
top.addWidget("org.kde.plasma.digitalclock");
top.addWidget("org.kde.plasma.panelspacer");
top.addWidget("org.kde.plasma.systemtray");

var dock = new Panel;
dock.location = "bottom";
dock.height = Math.round(gridUnit * 3);
dock.floating = true;
dock.lengthMode = "fit";
dock.alignment = "center";
dock.hiding = "dodgewindows";
var tasks = dock.addWidget("org.kde.plasma.icontasks");
tasks.currentConfigGroup = ["General"];
tasks.writeConfig("launchers", [
    "applications:org.kde.dolphin.desktop",
    "applications:firefox.desktop",
    "applications:org.kde.konsole.desktop",
    "applications:org.kde.kate.desktop",
    "applications:systemsettings.desktop"
]);
dock.addWidget("org.kde.plasma.marginsseparator");
var pager = dock.addWidget("org.kde.plasma.pager");
pager.currentConfigGroup = ["General"];
// Per-screen virtual desktops: each dock's pager drives its own screen.
pager.writeConfig("currentDesktopSelected", "ShowDesktop");

var desktops = desktopsForActivity(currentActivity());
for (var i = 0; i < desktops.length; i++) {
    desktops[i].wallpaperPlugin = "org.kde.image";
}
