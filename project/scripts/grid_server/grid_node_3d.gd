class_name GridNode3D extends Node3D

var grid_position: Vector3:
	get:
		return Grid.to_grid(position)
	set(value):
		grid_position = value
		position = Grid.to_coord(value)

var global_grid_position: Vector3:
	get:
		return Grid.to_grid(global_position)
	set(value):
		global_grid_position = value
		global_position = Grid.to_coord(value)

func _ready() -> void:
	get("grid_position")
	get("global_grid_position")
