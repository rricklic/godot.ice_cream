class_name TransitionSlide extends Transition

var start_position: Vector2
var end_position: Vector2
var duration: float

func _init(start_position: Vector2, end_position: Vector2, duration: float):
	self.start_position = start_position
	self.end_position = end_position
	self.duration = duration

func perform(node: Node2D) -> void:
	var tween: Tween = create_tween()
	var tweener: PropertyTweener = tween.tween_property(node, "global_position", end_position, duration).from(start_position)
	await tween.finished
