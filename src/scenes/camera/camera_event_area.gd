class_name CameraEventArea extends Area2D

################################################################################
# Description: An Area2D which will trigger some event when camera enters/exits
#     Examples: add/remove target
#               pan camera to some part of scene and return (follow path)
#               play animation/cutscene
################################################################################
	
var on_entered_func: Callable = func():
	pass
	
var on_exited_func: Callable = func():
	pass

func on_entered() -> void:
	on_entered_func.call()

func on_exited() -> void:
	on_exited_func.call()
