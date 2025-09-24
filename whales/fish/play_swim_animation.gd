extends Node3D

@export_category("Motion")
@export_range(0.0, 10.0, 0.1)
var amplitude: float = 0.5

@export_range(0.0, 5.0, 0.01)
var frequency: float = 0.25 # cycles per second

@export_range(0.0, 6.28319, 0.01)
var phase: float = 0.0

@export
var animate: bool = true

var _time: float = 0.0
var _origin: Vector3


func _ready() -> void:
	# Start swim animation if present
	if $AnimationPlayer:
		$AnimationPlayer.play("Armature|Swim")

	# Record local origin so the node oscillates around its start position
	_origin = transform.origin


func _process(delta: float) -> void:
	if not animate:
		return

	_time += delta
	var y_offset = amplitude * sin(2.0 * PI * frequency * _time + phase)
	var pos = _origin
	pos.y += y_offset
	var t = transform
	t.origin = pos
	transform = t
