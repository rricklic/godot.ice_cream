class_name CameraTraumaArea extends Area2D

################################################################################
# Description: An Area2D which represents trauma to apply to camera screen shake
#    Can be used for explosions, area of effects, scripted screen shakes, etc...
################################################################################

## Amount of trauma to apply to screen shake
@export_range(0.0, 1.0) var amount: float = 0.5

func _ready() -> void:
	body_entered.connect(_apply_trauma)

func _apply_trauma(node: Node2D) -> void:
	if (node is Player):
		CameraManager.apply_trauma(amount)
