extends MeshInstance3D

@export var vector2: Vector2 =  Vector2.ZERO

# Exports
@export var hoverMaterial: Material

# Visual effects
signal hover_enter
signal hover_exit

func _ready() -> void:
	# Connect local signals to handlers so visual effects still work
	connect("hover_enter", Callable(self, "_handle_hover_enter"))
	connect("hover_exit", Callable(self, "_handle_hover_exit"))


func on_hover_enter() -> void:
	# Emit the public signal so other scripts can react
	emit_signal("hover_enter", vector2)


func on_hover_exit() -> void:
	# Emit the public signal so other scripts can react
	emit_signal("hover_exit", vector2)


func _handle_hover_enter() -> void:
	set_surface_override_material(0, hoverMaterial)


func _handle_hover_exit() -> void:
	set_surface_override_material(0, null)


# Signals
func _on_area_3d_mouse_entered() -> void:
	on_hover_enter()

func _on_area_3d_mouse_exited() -> void:
	on_hover_exit()


func _on_area_3d_area_entered(_area: Area3D) -> void:
	on_hover_enter()


func _on_area_3d_area_exited(_area: Area3D) -> void:
	on_hover_exit()
