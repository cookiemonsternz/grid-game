@tool
extends MultiMeshInstance3D

@export_group("Grid Gen")
@export var size: Vector2i
@export var height_map: FastNoiseLite
@export_tool_button("Generate") var generate_function = generate_grid

func generate_grid():
	print("Generating")
	
