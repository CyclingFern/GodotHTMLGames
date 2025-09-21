extends Node3D

@export var max_speed: float = 10.0
@export var thrust_acceleration: float = 12.0
@export var thrust_deceleration: float = 6.0

@export var angular_speed: float = 3.0 # how fast roll rate reacts
@export var angular_damping: float = 4.0

var _velocity: Vector3 = Vector3.ZERO
var _left_input: Vector2 = Vector2.ZERO   # local X (right), Y (up/down)
var _right_input: Vector2 = Vector2.ZERO  # X = roll input (-1..1), Y = forward/back throttle (-1..1)
var _angular_velocity: Vector3 = Vector3.ZERO # radians/sec around (x=pitch,y=yaw,z=roll)

func set_left_stick_input(direction: Vector2) -> void:
	# direction.x -> local right, direction.y -> local up/down
	_left_input = direction.limit_length(1.0)


func set_right_stick_input(direction: Vector2) -> void:
	# direction.x -> roll control (-1..1), direction.y -> forward/back throttle (-1..1)
	_right_input = direction.limit_length(1.0)

func _physics_process(delta: float) -> void:

	# COMBINE INPUTS: left stick controls local X (right) and Y (up), right stick Y controls local forward/back
	var left_dir: Vector2 = _left_input
	var right_dir: Vector2 = _right_input

	var right_world: Vector3 = global_transform.basis.x
	var up_world: Vector3 = global_transform.basis.y
	var forward_world: Vector3 = global_transform.basis.z

	var desired_vel: Vector3 = (right_world * left_dir.x + up_world * left_dir.y + forward_world * right_dir.y) * max_speed

	# Acceleration vs deceleration depending on if there's any thrust input
	var has_thrust_input: bool = left_dir.length() > 0.001 or abs(right_dir.y) > 0.001
	var thrust_rate: float = thrust_acceleration if has_thrust_input else thrust_deceleration
	_velocity = _velocity.move_toward(desired_vel, thrust_rate * delta)

	# Apply translation (world axes)
	global_translate(_velocity * delta)



	# ANGULAR: right stick X controls roll rate (barrel roll). We'll damp when no input.
	var desired_roll_rate: float = _right_input.x * angular_speed
	_angular_velocity.z = lerp(_angular_velocity.z, desired_roll_rate, clamp(angular_damping * delta, 0.0, 1.0))

	# Integrate angular velocity into rotation (only roll is expected to change here)
	rotation += _angular_velocity * delta


	# Small snap to zero to avoid micro-jitter and damp roll back toward zero when no roll input
	if not has_thrust_input and _velocity.length() < 0.02:
		_velocity = Vector3.ZERO

	# When there's no roll input, ease angular roll back to zero
	if abs(_right_input.x) < 0.01:
		_angular_velocity.z = lerp(_angular_velocity.z, 0.0, clamp(angular_damping * delta, 0.0, 1.0))
		rotation.z = lerp(rotation.z, 0.0, clamp(angular_damping * delta, 0.0, 1.0))
		
	_left_input = Vector2.ZERO
	_right_input = Vector2.ZERO


func _on_vr_controller_teleport(vector2: Vector2) -> void:
	# Legacy handler: treat this input as thrust by default
	set_left_stick_input(vector2)
	# If you also have attitude/control input available, call `set_right_stick_input()` separately.


func _on_vr_controller_left_stick_move(input) -> void:
	set_left_stick_input(input)
