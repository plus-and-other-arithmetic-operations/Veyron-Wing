# Veyron-Wing

Pro-bono project for touge's Veyron.

## Wing breakdown

The Bugatti Veyron 16.4 is equipped with an adaptive rear wing system that adjusts its behavior based on the vehicle's speed. Here's an explanation of the wing behavior:

### 0 km/h to 100 km/h:

> **At speeds ranging from 0 km/h to 100 km/h**, the rear wing remains in a neutral position. This means that neither the wing nor the lip is actively engaged.


### 100 km/h to 200 km/h:

> **As the vehicle accelerates and reaches speeds between 100 km/h and 200 km/h**, both the wing and a rear lip become active.
> 
> The wing adjusts to an angle of 14 degrees, and the rear lip angles at 24 degrees.
> 
> Additionally, during this speed range, an airbrake function is activated. This helps enhance aerodynamic stability and downforce, contributing to improved handling at higher speeds.


### 200 km/h to 400 km/h:

> **As the vehicle continues to accelerate beyond 200 km/h**, a transition occurs in the rear wing system.
> 
> The large wing is replaced or complemented by a smaller rear lip with a reduced angle of 3 degrees.
> 
> The airbrake function remains active during this phase, aiding in managing the vehicle's aerodynamics at extremely high speeds.
> This adaptive wing system on the Bugatti Veyron 16.4 is designed to optimize aerodynamic efficiency and stability across a wide range of speeds.

The ability to transition between different wing configurations allows the vehicle to achieve the best balance between downforce and drag, contributing to its impressive performance capabilities.

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
