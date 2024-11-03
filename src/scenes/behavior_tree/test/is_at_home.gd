class_name IsAtHome extends BTLeaf

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var home: Node = blackboard.get_field(BTBlackboard.Field.HOME)
	if (home == null):
		return BehaviorTree.NodeState.FAILURE

	if (actor.global_position.distance_to(home.global_position) < 5):
		return BehaviorTree.NodeState.SUCCESS

	return BehaviorTree.NodeState.FAILURE
