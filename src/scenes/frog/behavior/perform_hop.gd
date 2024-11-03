class_name FrogHop extends BTLeaf

func _hop(actor: Node) -> void:
	actor.velocity.y = actor._jump_velocity
	actor.velocity.x = actor.hop_speed * randi_range(-1, 1)
	actor.scale = Vector2(0.7, 1.3)
	var tween: Tween = create_tween()
	tween.tween_property(actor, "scale", Vector2(1.0, 1.0), 0.25)
	await tween.finished

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var hops_left: float = blackboard.get_field(BTBlackboard.Field.FROG_HOPS_LEFT)
	if (hops_left <= 0 && actor.is_on_floor()):
		actor.scale = Vector2(1.3, 0.7)
		var tween: Tween = create_tween()
		tween.tween_property(actor, "scale", Vector2(1.0, 1.0), 0.25)		
		blackboard.set_field(BTBlackboard.Field.FROG_TIREDNESS, randf_range(0.5, 2.0))
		actor.velocity.x = 0
		return BehaviorTree.NodeState.SUCCESS
		
	if (actor.is_on_floor() && actor.velocity.y == 0):
		_hop(actor)
		blackboard.set_field(BTBlackboard.Field.FROG_HOPS_LEFT, hops_left - 1)

	return BehaviorTree.NodeState.RUNNING
