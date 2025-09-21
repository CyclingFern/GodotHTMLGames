extends MeshInstance3D

# Rotate 90 degrees on the z axis once a second

var time_accumulated := 0.0

func _ready() -> void:
	var randomQuarter = randi() % 4 * deg_to_rad(90)
	rotate_z(randomQuarter)

func _process(delta):
	if global_position.y >= 0.5:
		visible = false
		return
	else:
		visible = true
		
		time_accumulated += delta
		if time_accumulated >= 1.0:
			rotate_z(90)
			time_accumulated = 0.0
