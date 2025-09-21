extends MeshInstance3D

@export var direction: Vector2 =  Vector2.ZERO

# Exports
@export var hoverMaterial: Material

# Visual effects
signal hover_enter(vector2)
signal hover_exit(vector2)

signal teleport(vector2)

func _ready() -> void:
	# Connect local signals to handlers so visual effects still work
	connect("hover_enter", Callable(self, "_handle_hover_enter"))
	connect("hover_exit", Callable(self, "_handle_hover_exit"))


func on_hover_enter():
	# Emit the public signal so other scripts can react
	hover_enter.emit(direction)
	
	teleport.emit(direction)
	
	print("teleport one")


func on_hover_exit():
	# Emit the public signal so other scripts can react
	emit_signal("hover_exit", direction)


func _handle_hover_enter(direction) -> void:
	set_surface_override_material(0, hoverMaterial)


func _handle_hover_exit(direction) -> void:
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
