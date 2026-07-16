# MiniMapMod

A small MelonLoader minimap mod for A Township Tale.

## Controls

- `M`: open or close the minimap.
- `Refresh Players`: refresh player markers and labels.
- `Reload Map Background`: capture a fresh map background texture.
- `Refresh All`: refresh both the background and player markers.
- `Lock Map Background`: keep the current map background while refreshing players.
- `Size`: resize the minimap window.
- `Marker X/Y Offset`: adjust marker alignment over the captured map.

When the minimap is open, the menu controls sit directly underneath the map. Player markers are drawn from the available runtime player roster when possible, with a local-player fallback.

## Build

```powershell
.\build.ps1
```

By default this build uses the TavernLib copy from your flatscreen mod folder:

```text
..\FlatscreenATTMod\TavernLib-main\Dependencies
```

To use a different TavernLib checkout, pass `-TavernLibRoot C:\path\to\TavernLib-main`.

Copy `bin\Release\MiniMapMod.dll` into the game's `Mods` folder.
