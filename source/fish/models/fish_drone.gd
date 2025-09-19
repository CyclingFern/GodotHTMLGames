extends CharacterBody3D

@export var move_speed = 5 # Units per second
@export var rotation_speed = 3.0

var input_dir = Vector3()

func _ready() -> void:
	globals.fishPosition = position;

func _process(delta: float) -> void:
	input_dir = globals.vrControls
	globals.fishPosition = position;
	return

func _physics_process(delta):
	# Handle rotation
	var rotation_input = -input_dir.x
	if rotation_input != 0:
		rotate_y(deg_to_rad(rotation_input * rotation_speed))
	
	var movement_input = -input_dir.y
	if movement_input != 0:
		# Get the character's local forward direction
		var forward_direction = -transform.basis.z
		# Calculate velocity based on input, speed, and direction
		velocity = forward_direction * movement_input * move_speed
	else:
		# Stop movement when no input is given
		velocity = Vector3.ZERO

	move_and_slide()
	globals.eatVRControls()
