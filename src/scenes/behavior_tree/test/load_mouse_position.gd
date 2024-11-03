class_name LoadMousePosition extends BTLeaf

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	blackboard.set_field(BTBlackboard.Field.MOUSE_POSITION, mouse_position)
	return BehaviorTree.NodeState.SUCCESS
