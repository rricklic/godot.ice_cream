class_name Hitbox extends Area2D

################################################################################
# Description: 
################################################################################

var action_func: Callable = func(actor: Node2D):
	pass

var stop_func: Callable = func(actor: Node2D):
	pass

func perform_action(actor: Node2D) -> void:
	action_func.call(actor)

func stop_action(actor: Node2D) -> void:
	stop_func.call(actor)
