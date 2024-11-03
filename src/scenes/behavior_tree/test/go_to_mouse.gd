class_name GoToMouse extends BTLeaf

@export var speed: float = 300.0

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var mouse_position: Vector2 = blackboard.get_field(BTBlackboard.Field.MOUSE_POSITION)
	var delta: float = blackboard.get_field(BTBlackboard.Field.DELTA)
	if (mouse_position == null):
		return BehaviorTree.NodeState.FAILURE

	if (actor.global_position.distance_to(mouse_position) < 5):
		return BehaviorTree.NodeState.SUCCESS

	actor.global_position += (mouse_position - actor.global_position).normalized() * speed * delta
	return BehaviorTree.NodeState.RUNNING
