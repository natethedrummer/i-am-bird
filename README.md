# I Am Bird

A 3D physics-based game built in [Godot Engine 4](https://godotengine.org/) where you play as a bird navigating the world using realistic flight mechanics.

## Concept

You are a bird. Flap, soar, and glide through open environments using physics-driven flight. The game focuses on the tactile joy of movement — mastering lift, drag, and momentum to travel with grace or reckless speed.

## How to Play

| Input | Action |
|---|---|
| Mouse | Steer (yaw + pitch) |
| Space | Flap wings |
| Escape | Release cursor |

Flap a few times to build speed. Once you're moving fast enough, lift kicks in and you can glide — nose down to dive and gain speed, nose up to climb and slow down.

## Getting Started

> **Note:** Godot 4.6+ required. On older Macs (Intel GPU), the project uses the **GL Compatibility** renderer. Launch Godot with `--rendering-driver opengl3` if it crashes on startup.

1. Install [Godot 4.6](https://godotengine.org/download)
2. Clone this repository
3. Open Godot and import `project.godot`
4. Press **F5** to play

## Flight Physics

Implemented in `scripts/bird.gd`. All values are `@export` vars — tweak them live in the Godot Inspector without touching code.

| Parameter | Default | Effect |
|---|---|---|
| `gravity_strength` | 14.0 m/s² | Downward pull |
| `lift_coefficient` | 0.55 | Upward force per m/s of horizontal speed |
| `drag_coefficient` | 0.06 | Velocity damping per frame |
| `flap_up` | 9.0 m/s | Upward impulse per flap |
| `flap_forward` | 6.0 m/s | Forward impulse per flap |
| `flap_cooldown` | 0.4 s | Minimum time between flaps |

## Project Structure

```
i-am-bird/
├── assets/
│   ├── models/       # bird.glb — low-poly bird (Quaternius, CC0)
│   ├── textures/     # Image assets
│   └── audio/        # Sound effects and music
├── scenes/
│   └── main.tscn     # Greybox level: ground, platforms, tower, sky
└── scripts/
    └── bird.gd       # Flight physics controller
```

## Current State

- [x] Godot 4.6 project scaffolded (GL Compatibility renderer)
- [x] Greybox level — flat ground, two elevated platforms, a tower
- [x] Flight physics — gravity, lift, drag, flap, pitch authority
- [x] 3rd-person camera attached to bird
- [x] Low-poly bird model ([Quaternius](https://poly.pizza/m/gYYC0gYMnw), CC0)

## Up Next

- Wing-flap animation driven by flight state
- Sound effects (wind, flap, landing)
- A real environment to explore
- Objectives or collectibles tied to movement skill
