class_name FindHidingSpot extends BTLeaf

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var hinding_spots: Array[Node] = get_tree().get_nodes_in_group("hiding_spot")
	if (hinding_spots.size() == 0):
		return BehaviorTree.NodeState.FAILURE
	
	var closest_hinding_spot: Node = hinding_spots[0]
	var min_distance: float = actor.global_position.distance_squared_to(hinding_spots[0].global_position)
	for hinding_spot in hinding_spots:
		var distance: float = actor.global_position.distance_squared_to(hinding_spot.global_position)
		if (distance < min_distance):
			closest_hinding_spot = hinding_spot
			min_distance = distance
	blackboard.set_field(BTBlackboard.Field.HIDING_SPOT, closest_hinding_spot)
	return BehaviorTree.NodeState.SUCCESS
