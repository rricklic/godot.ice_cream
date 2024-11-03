class_name Stairs extends Node2D

################################################################################
# Description: 
################################################################################

@onready var lower_area: Area2D = $LowerArea
@onready var upper_area: Area2D = $UpperArea
@onready var upper_floor: Area2D = $UpperFloor

func _ready() -> void:
	lower_area.area_entered.connect(_lower_entered)
	lower_area.area_exited.connect(_lower_exited)
	upper_area.area_entered.connect(_upper_entered)
	upper_area.area_exited.connect(_upper_exited)	
	
func _lower_entered(area: Area2D) -> void:
	pass

func _lower_exited(area: Area2D) -> void:
	pass

func _upper_entered(area: Area2D) -> void:
	pass
	
func _upper_exited(area: Area2D) -> void:
	pass
