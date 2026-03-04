extends CharacterBody3D

# Bird player controller.
# Flight physics will be implemented in Issue #2.

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
