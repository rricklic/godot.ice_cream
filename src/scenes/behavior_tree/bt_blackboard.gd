class_name BTBlackboard extends RefCounted

enum Field {
	DELTA,
	MOUSE_POSITION,
	HOME,
	FROG_TIREDNESS,
	FROG_HOPS_LEFT,
	HIDING_SPOT
}

var blackboard: Dictionary = {} # StringName -> {Field -> Variant}

func set_field(field: BTBlackboard.Field, value: Variant, blackboard_name: StringName = "default") -> void:
	if (!blackboard.has(blackboard_name)):
		blackboard[blackboard_name] = {}
	blackboard[blackboard_name][field] = value

func get_field(field: BTBlackboard.Field, default_value: Variant = null, blackboard_name: StringName = "default") -> Variant:
	if (blackboard.has(blackboard_name)):
		return blackboard[blackboard_name].get(field, default_value) 
	return default_value;

func has_field(field: BTBlackboard.Field, blackboard_name: StringName = "default") -> bool:
	return blackboard.has(blackboard_name) && blackboard[blackboard_name].has(field)

func erase_field(field: BTBlackboard.Field, blackboard_name: StringName = "default") -> void:
	if (blackboard.has(blackboard_name)):
		blackboard[blackboard_name].erase(field)
