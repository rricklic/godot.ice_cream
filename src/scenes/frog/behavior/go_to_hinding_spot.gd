class_name GoToHidingSpot extends BTLeaf

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var hiding_spot: Node = blackboard.get_field(BTBlackboard.Field.HIDING_SPOT)
	var delta: float = blackboard.get_field(BTBlackboard.Field.DELTA)
	if (hiding_spot == null):
		return BehaviorTree.NodeState.FAILURE

	if (actor.global_position.distance_to(hiding_spot.global_position) < 25):
		return BehaviorTree.NodeState.SUCCESS

	var distance_x: float = hiding_spot.global_position.x - actor.global_position.x

	if (actor.is_on_floor() && actor.velocity.y == 0):
		actor.velocity.y = actor._jump_velocity
		if (abs(distance_x) < actor.hide_speed * delta):
			actor.velocity.x = distance_x / delta
		else:
			actor.velocity.x = actor.hide_speed * sign(distance_x)

	return BehaviorTree.NodeState.RUNNING
