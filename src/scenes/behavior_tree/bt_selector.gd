class_name BTSelector extends Node

func _get_configuration_warnings() -> PackedStringArray:
	if (get_child_count() == 0):
		return ["BTSelector requires at least one child of type BTSelector, BTSequence, BTDecorator, or BTLeaf"]
	return []

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	for child: Node in get_children():
		var state: BehaviorTree.NodeState = child.tick(actor, blackboard)
		if (state != BehaviorTree.NodeState.FAILURE):
			return state
	return BehaviorTree.NodeState.FAILURE
