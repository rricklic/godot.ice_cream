class_name ChangeColor extends BTLeaf

@export var color: Color = Color(1, 0, 0)

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	actor.modulate = color
	return BehaviorTree.NodeState.SUCCESS
