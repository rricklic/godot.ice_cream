extends Node

# Autoload CameraManager

var cameras: Dictionary # StringName -> Camera
var current: Camera

func add(name: StringName, camera: Camera) -> bool:
	if (cameras.has(name)):
		return false
	if (current == null):
		current = camera
	cameras[name] = camera
	return true
	
func remove(name: StringName) -> bool:
	if (!(cameras.has(name))):
		return false
	cameras.erase(name)
	return true

func get_camera(name: StringName) -> Camera:
	if (cameras.has(name)):
		return cameras[name]
	return null

func make_current(name: StringName) -> bool:
	if (!cameras.has(name)):
		return false
	var camera: Camera = cameras[name]
	camera.camera2d.make_current()
	current = camera
	return true

func add_target(node: Node2D) -> void:
	node.tree_exiting.connect(remove_if_target_deleted.bind(node))
	if (current != null):
		current.add_target(node)
	
func remove_target(node: Node2D) -> void:
	if (current != null):
		current.remove_target(node)

func clear_targets() -> void:
	if (current != null):
		current.clear_targets()

func set_target_offset(target_offset: Vector2) -> void:
	if (current != null):
		current.set_target_offset(target_offset)

func apply_trauma(trauma: float) -> void:
	if (current != null):
		current.apply_trauma(trauma)

func remove_if_target_deleted(node :Node2D) -> void:
	if (node.is_queued_for_deletion()):
		remove_target(node)
