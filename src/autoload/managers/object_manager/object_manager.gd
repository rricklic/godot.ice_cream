extends Node

# Autoload ObjectManager

enum TrackedObject {
	Player,
	Camera
}

var objects: Dictionary = {} # StringName -> Object
var packed_scenes: Dictionary = {} # StringName -> PackedScene

func _create_scene(name: StringName, res: String) -> Node:
	var packed_scene: PackedScene
	if (packed_scenes.has(name)):
		packed_scene = packed_scenes[name]
	else:
		packed_scene = load(res)
		packed_scenes[name] = packed_scene
	return packed_scene.instantiate()

func take(name: StringName) -> Object:
	if (!objects.has(name)):
		return null
	var object: Object = objects[name]
	objects.erase(name)
	return object

func take_or_create(name: StringName, res: String) -> Object:
	var object: Object = take(name)
	if (object != null):
		return object
	return _create_scene(name, res)

# TODO:
#func take_or_create_object(name: StringName, class: Class) -> Object:
#	if (cached_objects.has(name)):
#		return cached_objects[name]
#	return _create_object(name, class)

func has(name: StringName) -> bool:
	return objects.has(name)

func _remove_object_from_parent(object: Object) -> void:
	if (!(object is Node)):
		return
	var parent: Node = object.get_parent()
	if (parent != null):
		parent.remove_child(object)

func giveup(name: StringName, object: Object) -> bool:
	if (objects.has(name)):
		return false
	_remove_object_from_parent(object)
	objects[name] = object
	return true

func find_from(object: TrackedObject, node: Node) -> Object:
	return node.find_child(TrackedObject.keys()[object])

func remove_all(name: StringName) -> bool:
	remove_packed_scene(name)
	return remove_object(name)

func remove_object(name: StringName) -> bool:
	return objects.erase(name)

func remove_packed_scene(name: StringName) -> bool:
	return packed_scenes.erase(name)

func free_object(name: StringName) -> bool:
	var object: Object = take(name)
	if (object == null):
		return false
	object.queue_free()
	return true

func clear() -> void:
	for object: Object in objects.values():
		object.queue_free()
	objects.clear()
	packed_scenes.clear()

# TODO: connect this function to all object.tree_exiting signals
func _check_queued_for_deletion(object: Object) -> void:
	if (object.is_queued_for_deletion()):
		pass # TODO: remove object from objects
