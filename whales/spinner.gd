extends Node3D

@export var rotation_speed = 1.0 # Speed in radians per second

func _process(delta):
	# Rotate the object around its local y-axis.
	rotate(Vector3.UP, rotation_speed * delta)
