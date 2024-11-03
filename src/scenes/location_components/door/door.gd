class_name Door extends Area2D

# Note: We are using the scene resource path as opposed to a PackedScene
#       because there may be circular dependencies (e.g. Scene1 <---> Scene2).
#       As of Godot 4.2, this will cause one of the scene to be unable to load.
@export var scene: String

var is_in_door: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(node: Node2D) -> void:
	if (node is Player):
		is_in_door = true
		print("is_in_door " + str(is_in_door))
		
func _on_body_exited(node: Node2D) -> void:
	if (node is Player):
		is_in_door = false
		print("is_in_door " + str(is_in_door))
		
func _unhandled_input(event: InputEvent) -> void:
	if (is_in_door && Input.is_action_just_pressed("p1_button_2")):
		SceneManager.transition_scene_file(
			owner,
			scene,
			TransitionColorFade.new(Color(0, 0, 0, 0), Color.BLACK, 1.0),
			TransitionColorFade.new(Color.BLACK, Color(0, 0, 0, 0), 1.0))
