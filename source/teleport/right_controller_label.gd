extends Label3D

func _process(delta: float) -> void:
	text = str($"../..".get_input("trigger_click"))
