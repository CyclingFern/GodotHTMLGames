extends Label3D



func _on_right_controller_input_float_changed(name: String, value: float) -> void:
	text = name + " : " + str(value)
