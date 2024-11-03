class_name Home extends Node2D

var player: Player
var camera: Camera

const resource_path: String = "res://src/scenes/locations/home/home.tscn"

@onready var start: Marker2D = $Start
@onready var enter: Marker2D = $Enter
@onready var camera_min_point: Marker2D = $CameraMinPoint
@onready var camera_max_point: Marker2D = $CameraMaxPoint

func _initialize() -> void:
	get_script().get_path()
	player = ObjectManager.take("Player") as Player
	add_child(player)
	camera = ObjectManager.take("Camera") as Camera
	add_child(camera)

	match SceneManager.last_scene_name:
		"Town": player.global_position = enter.global_position
		_: player.global_position = start.global_position

	#camera.limit_left = camera_min_point.global_position.x
	#camera.limit_right = camera_max_point.global_position.x
	#camera.limit_top = camera_min_point.global_position.y
	#camera.limit_bottom = camera_max_point.global_position.y
	camera.global_position = player.global_position
	
func _enter_tree() -> void:
	if (is_node_ready()):
		_initialize()

func _ready() -> void:
	_initialize()

func _exit_tree() -> void:
	ObjectManager.giveup("Player", player)
	ObjectManager.giveup("Camera", camera)
