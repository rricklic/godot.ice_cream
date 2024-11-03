class_name IsAtHidingSpot extends BTLeaf

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var hiding_spot: Node = blackboard.get_field(BTBlackboard.Field.HIDING_SPOT)
	if (actor.global_position.distance_to(hiding_spot.global_position) < 25):
		actor.queue_free()
		return BehaviorTree.NodeState.SUCCESS

	return BehaviorTree.NodeState.FAILURE

