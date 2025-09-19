extends CharacterBody3D

@export var move_speed = 5 # Units per second

func _physics_process(delta):
	look_at(position.direction_to(globals.fishPosition))
	if (position.distance_to(globals.fishPosition) > 2):
		position = position.move_toward(globals.fishPosition, move_speed * delta)
