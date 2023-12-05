# Veyron-Wing

Pro-bono project for touge's Veyron.

# Setup

Prepare the extra switches, bind extra D to the wing animation:

```ini
[EXTRA_SWITCHES] ;Loading menu description of switches (for some reason, it doesn't capitalize the first letter...)
SWITCH_D = Wing up

[ANIMATION_...]
FILE = WING_EXTRA.ksanim
INPUT = EXTRA_D
TIME = 5
```

Add the script entry:

```ini
[SCRIPTABLE_DISPLAY_...]
ACTIVE = 1
MESHES = EXT_NWORD
RESOLUTION = 512,512
DISPLAY_POS = 0,0
DISPLAY_SIZE = 512,512
SKIP_FRAMES = 0
SCRIPT = wing.lua
```
