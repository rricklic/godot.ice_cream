class_name IsFrogTired extends BTLeaf

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	if (!blackboard.has_field(BTBlackboard.Field.FROG_TIREDNESS)):
		return BehaviorTree.NodeState.FAILURE

	var tiredness: float = blackboard.get_field(BTBlackboard.Field.FROG_TIREDNESS)
	var delta: float = blackboard.get_field(BTBlackboard.Field.DELTA)
	tiredness -= delta
	blackboard.set_field(BTBlackboard.Field.FROG_TIREDNESS, tiredness)
	if (tiredness <= 0):
		return BehaviorTree.NodeState.FAILURE

	return BehaviorTree.NodeState.SUCCESS
