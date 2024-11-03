class_name TransitionManager extends Node

# Autoload TransitionManager

# transform
# shader
# animation
func transition(node: Node2D, transition: Transition) -> void:
	if (transition == null):
		return

	add_child(transition)
	await transition.perform(node)
	transition.queue_free()
