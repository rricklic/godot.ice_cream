class_name IsFrogScared extends BTLeaf

@export var distance: float = 50.0
@export var time_to_scare: float = 2.0

var scare_timer: float = 0
var is_scared: bool = false

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	if (is_scared):
		return BehaviorTree.NodeState.SUCCESS

	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var delta: float = blackboard.get_field(BTBlackboard.Field.DELTA)
	if (mouse_position.distance_to(actor.global_position) <= distance):
		scare_timer += delta
	elif scare_timer > 0:
		scare_timer -= delta
		if (scare_timer < 0):
			scare_timer = 0

	if (scare_timer >= time_to_scare):
		is_scared = true
		return BehaviorTree.NodeState.SUCCESS

	return BehaviorTree.NodeState.FAILURE
