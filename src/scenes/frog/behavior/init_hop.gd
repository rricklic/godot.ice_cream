class_name InitHop extends BTLeaf

## Maximum number of hops in a series
@export var max_num_hops: int = 5

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	blackboard.set_field(BTBlackboard.Field.FROG_HOPS_LEFT, randi_range(1, max_num_hops))
	return BehaviorTree.NodeState.SUCCESS
