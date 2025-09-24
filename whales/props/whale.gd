extends Node3D

@onready var characterBody = $CharacterBody3D

#--- Fish Behavior Parameters ---
@export var speed: float = 3.0
@export var turn_speed: float = 2.0
@export var wander_radius: float = 10.0

# Assign a Node3D in the Inspector to act as the center of the wander area.
@export var origin_node: Node3D = null

@export var time_going_max = 10

var wander_target: Vector3 = Vector3.ZERO
var origin_position: Vector3 = Vector3.ZERO
var time_going: float = 0


# The _ready() function is called once when the node enters the scene tree.
func _ready():
	time_going_max = time_going_max + randi_range(-2, 2)
	# Set the origin for the wandering behavior.
	# If an origin_node is assigned, use its position.
	if origin_node != null:
		origin_position = origin_node.global_position
	# Otherwise, use this node's own starting position as the origin.
	else:
		origin_position = global_position
	
	# Set the initial random target position for the fish to swim towards.
	_update_wander_target()

# The _physics_process() function is called every physics frame.
func _physics_process(delta: float):
	time_going += delta
	# 1. Check distance to the target
	if characterBody.global_position.distance_to(wander_target) < 1.0 || time_going >= time_going_max:
		_update_wander_target()

	# 2. Calculate direction and rotate the fish
	var direction = characterBody.global_position.direction_to(wander_target)
	characterBody.transform.basis = characterBody.transform.basis.slerp(Basis.looking_at(direction), turn_speed * delta)

	# 3. Set velocity and move
	characterBody.velocity = -characterBody.global_transform.basis.z * speed
	characterBody.move_and_slide()


# This function calculates a new random position for the fish to swim to.
func _update_wander_target():
	if origin_node != null:
		origin_position = origin_node.global_position
	# Generate a random 3D direction.
	var random_direction = Vector3(
		randf_range(-1, 1),
		randf_range(-0.2, 0.2), # Keep vertical movement less pronounced
		randf_range(-1, 1)
	).normalized()
	
	# Set the new target within the wander_radius from the chosen origin_position.
	wander_target = origin_position + random_direction * wander_radius
	time_going = 0
