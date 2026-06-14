extends Node

@export var target: GridNode3D
@export var use_grid: bool = false
@export var speed: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_vector = Vector3(
		Input.get_axis("left", "right"),
		0,
		Input.get_axis("forward", "back")
	)
	move(input_vector, delta)

func move(dir: Vector3, delta: float):
	if use_grid:
		target.grid_position += dir
	else:
		dir = (dir.z * target.transform.basis.z) + (dir.x * target.transform.basis.x)
		target.position += dir.normalized() * speed * delta
