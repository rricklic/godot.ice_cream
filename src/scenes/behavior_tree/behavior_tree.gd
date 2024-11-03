class_name BehaviorTree extends Node

enum NodeState {
	SUCCESS,
	FAILURE,
	RUNNING
}

const blackboard_resource: Resource = preload("res://src/scenes/behavior_tree/bt_blackboard.gd")

@onready var blackboard: BTBlackboard = blackboard_resource.new()
@onready var actor: Node = get_parent()
@onready var root: Node = get_child(0)

func _get_configuration_warnings() -> PackedStringArray:
	if (get_child_count() != 1):
		return ["Behavior tree must have a single child (root) of type BTComposite or BTLeaf"]
		
	if (!(get_child(0) is BTSequence || get_child(0) is BTSelector || get_child(0) is BTLeaf)):
		return ["Behavior tree must have a single child (root) of type BTSequence, BTSelector, or BTLeaf"]
		
	return []

func _physics_process(delta: float) -> void:
	blackboard.set_field(BTBlackboard.Field.DELTA, delta)
	root.tick(actor, blackboard)
