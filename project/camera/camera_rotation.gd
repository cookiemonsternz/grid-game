extends Node

const MOUSE_LOOK_SCALE = 0.01

@export var target: Node3D

@export var pivot_yaw: Node3D
@export var pivot_pitch: Node3D

@export_group("Rotation Limits")
@export var soft_limit: bool
@export var soft_limit_amount: float
@export var min_pitch: float
@export var max_pitch: float

var lock_look: bool = false

func _input(event: InputEvent) -> void:
	if lock_look: return
	if event is InputEventMouseMotion and Input.is_action_pressed("camera_rotate"):
		var angle_x = event.screen_relative.x \
			* MOUSE_LOOK_SCALE \
			* Settings.mouse_sense.x
		var angle_y = event.screen_relative.y \
			* MOUSE_LOOK_SCALE \
			* Settings.mouse_sense.y
		
		if soft_limit:
			var curr_angle = pivot_pitch.rotation_degrees.x
			var dist_to_limit = min(
				abs(min_pitch - curr_angle),
				abs(max_pitch - curr_angle)
			)
			
			var dir_to_limit = 1.0 if abs(min_pitch - curr_angle) > abs(max_pitch - curr_angle) else -1.0
			
			#print("min: ", snapped(abs(min_pitch - curr_angle), 0.1), " max: ", snapped(abs(max_pitch - curr_angle), 0.1), " dir: ", dir_to_limit, " sign: ", sign(-angle_y))
			#print("damping: ", dist_to_limit / soft_limit_amount)
			
			angle_y *= min(dist_to_limit / soft_limit_amount, 1.0) if dir_to_limit == sign(-angle_y) else 1.0
		
		pivot_pitch.rotate_x(-angle_y)
		pivot_yaw.rotate_y(-angle_x)
		
		if !soft_limit:
			pivot_pitch.rotation_degrees.x = clamp(pivot_pitch.rotation_degrees.x, min_pitch, max_pitch)
