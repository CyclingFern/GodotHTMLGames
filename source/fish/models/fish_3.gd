extends Node3D

@onready var animation_player = $AnimationPlayer

func _ready():
	# Play a specific animation
	animation_player.play("Armature|Swim")
	animation_player.play("Armature|Swim_001")
