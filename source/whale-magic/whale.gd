extends Node3D

@export
var rotation_sensitivity: float = 2.0

var _thumbstick_input: Vector2 = Vector2.ZERO

@export_category("Orbit")
@export_range(0.0, 12.0, 0.1)
var radius: float = 5.0

@export_range(0.1, 20.0, 0.1)
var min_radius: float = 1.0

@export_range(0.1, 100.0, 0.1)
var max_radius: float = 20.0

@export_range(0.0, 6.28319, 0.01)
var angular_speed: float = 0.8 # radians per second

@export
var radius_sensitivity: float = 2.0

@export
var height_sensitivity: float = 1.5

@export
var center: Vector3 = Vector3.ZERO

var _angle: float = 0.0
var _height: float = 0.0

@export
var orientation_offset_degrees: Vector3 = Vector3(0, 90, 0)

func _ready() -> void:
	$AnimationPlayer.play("Armature|Swim")
	# Initialize height relative to center
	_height = transform.origin.y - center.y

func _process(delta: float) -> void:
	# Update angle to orbit around the center
	_angle += angular_speed * delta

	# Thumbstick x -> radius, y -> height (up/down)
	if _thumbstick_input != Vector2.ZERO:
		radius += _thumbstick_input.x * radius_sensitivity * delta
		_height += _thumbstick_input.y * height_sensitivity * delta
		radius = clamp(radius, min_radius, max_radius)
		_thumbstick_input = Vector2.ZERO

	# Compute local position around center
	var x = center.x + radius * cos(_angle)
	var z = center.z + radius * sin(_angle)
	var y = center.y + _height
	var pos = Vector3(x, y, z)

	var t = transform
	t.origin = pos
	transform = t

	# Make the whale look at the orbit center so it faces inward
	look_at(center, Vector3.UP)

	# Apply orientation offset (convert degrees to radians)
	if orientation_offset_degrees != Vector3.ZERO:
		var offset_rad = orientation_offset_degrees * (PI / 180.0)
		# Apply local rotation offsets in order (x, y, z)
		rotate_object_local(Vector3.RIGHT, offset_rad.x)
		rotate_object_local(Vector3.UP, offset_rad.y)
		rotate_object_local(Vector3.BACK, offset_rad.z)

func _on_node_3d_left_thumbstick_moved(vec: Vector2) -> void:
	# Store thumbstick vector; actual movement applied in _process(delta)
	_thumbstick_input = vec
