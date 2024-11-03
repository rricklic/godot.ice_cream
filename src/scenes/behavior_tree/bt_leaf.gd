class_name BTLeaf extends Node

func _get_configuration_warnings() -> PackedStringArray:
	if (get_child_count() != 0):
		return ["BTLeaf must have no children"]
	return []

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	return BehaviorTree.NodeState.SUCCESS
