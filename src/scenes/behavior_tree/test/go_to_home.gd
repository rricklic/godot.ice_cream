class_name GoToHome extends BTLeaf

@export var speed: float = 300.0

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var home: Node = blackboard.get_field(BTBlackboard.Field.HOME)
	var delta: float = blackboard.get_field(BTBlackboard.Field.DELTA)
	if (home == null):
		return BehaviorTree.NodeState.FAILURE

	if (actor.global_position.distance_to(home.global_position) < 5):
		return BehaviorTree.NodeState.SUCCESS

	actor.global_position += (home.global_position - actor.global_position).normalized() * speed * delta
	return BehaviorTree.NodeState.RUNNING
