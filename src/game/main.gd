class_name Main extends Node2D

@onready var player: Player = $Player
@onready var camera: Camera = $Camera

func _ready() -> void:
	SceneManager.set_current_scene(self)
	CameraManager.add("Camera", camera)
	CameraManager.add_target(player)

func _unhandled_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("p1_button_start")):
		SceneManager.transition_scene_file(
			self,
			Home.resource_path,
			TransitionColorFade.new(Color(0, 0, 0, 0), Color.BLACK, 1.0),
			TransitionColorFade.new(Color.BLACK, Color(0, 0, 0, 0), 1.0)
			)

func _exit_tree() -> void:
	ObjectManager.giveup("Player", player)
	ObjectManager.giveup("Camera", camera)
