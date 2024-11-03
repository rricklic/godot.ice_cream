class_name TrailEffect extends Line2D

@export var target: Node2D = self
@export var max_queue_length: int = 50

@onready var curve: Curve2D = Curve2D.new()

func _process(delta: float) -> void:
	curve.add_point(target.position)

	if (curve.get_baked_points().size() > max_queue_length):
		curve.remove_point(0)

	points = curve.get_baked_points()
