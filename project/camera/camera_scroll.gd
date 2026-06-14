extends Node

@export var target: PathFollow3D
@export var scroll_amount: float

func _input(event: InputEvent) -> void:
	if event.is_action("zoom_in") and target.progress_ratio > 0:
		var target_ratio = max(target.progress_ratio-scroll_amount, 0)
		
		var tween = target.create_tween()
		tween.tween_property(target, "progress_ratio", target_ratio, 0.25)
		tween.set_trans(Tween.TRANS_QUART)
	if event.is_action("zoom_out") and target.progress_ratio < 1:
		var target_ratio = min(target.progress_ratio+scroll_amount, 1)
		
		var tween = target.create_tween()
		tween.tween_property(target, "progress_ratio", target_ratio, 0.25)
		tween.set_trans(Tween.TRANS_QUART)
	
