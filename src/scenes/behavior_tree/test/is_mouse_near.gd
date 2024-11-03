class_name IsMouseNear extends BTLeaf

@export var distance: float = 300

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var mouse_position: Vector2 = blackboard.get_field(BTBlackboard.Field.MOUSE_POSITION)
	if (mouse_position == null):
		return BehaviorTree.NodeState.FAILURE
	if (mouse_position.distance_to(actor.global_position) <= distance):
		return BehaviorTree.NodeState.SUCCESS
	return BehaviorTree.NodeState.FAILURE
