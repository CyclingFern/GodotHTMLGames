extends Node3D

@export_category("Motion")
@export_range(0.0, 10.0, 0.1)
var amplitude: float = 0.25

@export_range(0.0, 5.0, 0.01)
var frequency: float = 0.5 # cycles per second

@export_range(0.0, 6.28319, 0.01)
var phase: float = 0.0

@export
var animate: bool = true

var _time: float = 0.0
var _origin: Vector3

func _ready() -> void:
	# capture the local origin so bobbing is relative to the node's start position
	_origin = transform.origin

func _process(delta: float) -> void:
	if not animate:
		return

	_time += delta
	var y_offset = amplitude * sin(2.0 * PI * frequency * _time + phase)

	var new_transform = transform
	var pos = _origin
	pos.y += y_offset
	new_transform.origin = pos
	transform = new_transform
