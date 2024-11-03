class_name BTSequence extends Node

func _get_configuration_warnings() -> PackedStringArray:
	if (get_child_count() == 0):
		return ["BTSequence requires at least one child of type BTSelector, BTSequence, BTDecorator, or BTLeaf"]
	return []

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	for child: Node in get_children():
		var state: BehaviorTree.NodeState = child.tick(actor, blackboard)
		if (state != BehaviorTree.NodeState.SUCCESS):
			return state
	return BehaviorTree.NodeState.SUCCESS
