class_name TransitionColorFade extends Transition

var start_color: Color
var end_color: Color
var duration: float

func _init(start_color: Color, end_color: Color, duration: float):
	self.start_color = start_color
	self.end_color = end_color
	self.duration = duration

func perform(node: Node2D) -> void:
	var canvas_layer: CanvasLayer = CanvasLayer.new()
	var color_rect: ColorRect = ColorRect.new()
	color_rect.anchors_preset = Control.LayoutPreset.PRESET_FULL_RECT
	color_rect.size = get_tree().root.content_scale_size
	color_rect.color = start_color
	canvas_layer.add_child(color_rect)
	node.add_child(canvas_layer)
	var tween: Tween = create_tween()
	var tweener: PropertyTweener = tween.tween_property(color_rect, "color", end_color, duration).from(start_color)
	await tween.finished
	canvas_layer.queue_free()
	color_rect.queue_free()
