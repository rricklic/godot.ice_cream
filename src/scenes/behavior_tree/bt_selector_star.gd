class_name BTSelectorStar extends Node

var running_node: Node = null

func _get_configuration_warnings() -> PackedStringArray:
	if (get_child_count() == 0):
		return ["BTSelectorStar requires at least one child of type BTSelector, BTSequence, BTDecorator, or BTLeaf"]
	return []

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	for child: Node in get_children():
		if (running_node != null && child != running_node):
			continue
		var state: BehaviorTree.NodeState = child.tick(actor, blackboard)
		running_node = child if state == BehaviorTree.NodeState.RUNNING else null
		if (state != BehaviorTree.NodeState.FAILURE):
			return state
	return BehaviorTree.NodeState.FAILURE
