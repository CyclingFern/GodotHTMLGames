extends CharacterBody3D

@onready var leftHand = $XROrigin3D/LeftController

func _process(delta: float) -> void:
	if leftHand.get_float("trigger") >= 0.8:
		var direction = -leftHand.global_transform.basis.z.normalized()
		var speed = 5.0 # Adjust speed as needed
		velocity = direction * speed
		move_and_slide() # move and slide in direction of hand node
