class_name FindClosestHome extends BTLeaf

func tick(actor: Node, blackboard: BTBlackboard) -> BehaviorTree.NodeState:
	var homes: Array[Node] = get_tree().get_nodes_in_group("home")
	if (homes.size() == 0):
		return BehaviorTree.NodeState.FAILURE
	
	var closest_home: Node = homes[0]
	var min_distance: float = actor.global_position.distance_squared_to(homes[0].global_position)
	for home in homes:
		var distance: float = actor.global_position.distance_squared_to(home.global_position)
		if (distance < min_distance):
			closest_home = home
			min_distance = distance
	blackboard.set_field(BTBlackboard.Field.HOME, closest_home)
	return BehaviorTree.NodeState.SUCCESS
