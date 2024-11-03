class_name Test extends Node2D

@onready var frog_test: Sprite2D = $FrogTest

func _ready() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(frog_test, "scale", Vector2(1.0, 1.0), 0.5).from(Vector2(5.0, 5.0))
	tween.tween_property(frog_test, "scale", Vector2(5.0, 5.0), 0.05).from(Vector2(1.0, 1.0))
	tween.set_loops()
	
	var tween2: Tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween2.tween_property(frog_test, "rotation_degrees", -45, 0.5).from(45)
	tween2.tween_property(frog_test, "rotation_degrees", 45, 0.5).from(-45)
	tween2.set_loops()	



################################################################################
# PROCESSING
################################################################################

# Called as fast as possible, so delta is not constant
func _process(delta: float) -> void:
	pass

# Called in sync with frame rate (1/60th second), so delta should be constant
func _physics_process(delta: float) -> void:
	pass

################################################################################
# INPUT
################################################################################

# Called when there is an input event. The input event propagates up through the
# node tree until a node consumes it: Viewport.set_input_as_handled() .
func _input(event: InputEvent) -> void:
	pass

# Called when an input event hasn't been consumed by _input(). The input event
# propagates up through the node tree until a node consumes it.
func _shortcut_input(event: InputEvent) -> void:
	pass
	
# Called when an input event hasn't been consumed by _input() or any GUI Control
# item. It is called after _shortcut_input() but before _unhandled_input(). The
# input event propagates up through the node tree until a node consumes it.
func _unhandled_key_input(event: InputEvent) -> void:
	pass

# Called when an input event hasn't been consumed by _input() or any GUI Control
# item. It is called after _shortcut_input() and after _unhandled_key_input().
# The input event propagates up through the node tree until a node consumes it.
func _unhandled_input(event: InputEvent) -> void:
	pass

func _notification(what: int) -> void:
	pass

################################################################################
# RENDERING
################################################################################

# Called when CanvasItem has been requested to redraw (after queue_redraw()
func _draw() -> void:
	pass

