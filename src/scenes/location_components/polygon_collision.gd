class_name PolygonCollision extends StaticBody2D

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

func _ready() -> void:
	collision_polygon_2d = CollisionPolygon2D.new()
	collision_polygon_2d.polygon = polygon_2d.polygon
	add_child(collision_polygon_2d)
