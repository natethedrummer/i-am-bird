extends CharacterBody3D

# ── Tuning ──────────────────────────────────────────────────────────────────
@export var gravity_strength: float = 14.0   ## downward pull (m/s²)
@export var lift_coefficient: float = 0.55   ## upward force per m/s of horizontal speed
@export var drag_coefficient: float = 0.06   ## velocity damping per physics frame
@export var flap_up: float = 9.0             ## upward impulse on flap (m/s)
@export var flap_forward: float = 6.0        ## forward impulse on flap (m/s)
@export var flap_cooldown: float = 0.4       ## minimum seconds between flaps
@export var mouse_sensitivity: float = 0.003 ## radians per pixel of mouse movement
@export var pitch_limit_up: float = 55.0     ## max nose-up angle (degrees)
@export var pitch_limit_down: float = -80.0  ## max nose-down angle (degrees)

# ── Internal state ───────────────────────────────────────────────────────────
var _yaw: float = 0.0
var _pitch: float = 0.0
var _flap_timer: float = 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_yaw   -= event.relative.x * mouse_sensitivity
		_pitch -= event.relative.y * mouse_sensitivity
		_pitch  = clamp(_pitch,
						deg_to_rad(pitch_limit_down),
						deg_to_rad(pitch_limit_up))
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	_flap_timer -= delta

	# Nose direction from mouse-driven yaw + pitch
	var forward := Vector3(
		-sin(_yaw) * cos(_pitch),
		 sin(_pitch),
		-cos(_yaw) * cos(_pitch)
	).normalized()

	# ── Gravity ───────────────────────────────────────────────────────────
	velocity.y -= gravity_strength * delta

	# ── Lift ──────────────────────────────────────────────────────────────
	# Horizontal airspeed generates upward force. At ~25 m/s the bird can
	# glide indefinitely; below ~5 m/s it will lose altitude and stall.
	var horiz_speed := Vector2(velocity.x, velocity.z).length()
	var lift        := clampf(lift_coefficient * horiz_speed, 0.0, gravity_strength)
	velocity.y += lift * delta

	# ── Pitch authority ───────────────────────────────────────────────────
	# Nose-up climbs (bleeding speed); nose-down dives (gaining speed).
	velocity += forward * sin(_pitch) * 6.0 * delta

	# ── Drag ──────────────────────────────────────────────────────────────
	velocity -= velocity * drag_coefficient * delta

	# ── Flap (Space / ui_accept) ─────────────────────────────────────────
	if Input.is_action_just_pressed("ui_accept") and _flap_timer <= 0.0:
		velocity.y  += flap_up
		velocity    += forward * flap_forward
		_flap_timer  = flap_cooldown

	# ── Body orientation ──────────────────────────────────────────────────
	rotation.y = _yaw
	rotation.x = _pitch * 0.65   # body tilts with nose direction

	move_and_slide()
