class_name Town extends Node2D

var player: Player
var camera: Camera

@onready var door: Door = $Home/Door
@onready var start: Marker2D = $Start
@onready var camera_min_point: Marker2D = $CameraMinPoint
@onready var camera_max_point: Marker2D = $CameraMaxPoint
@onready var hitbox: Hitbox = $Hitbox

func _initialize() -> void:
	player = ObjectManager.take("Player") as Player
	add_child(player)
	camera = ObjectManager.take("Camera") as Camera
	add_child(camera)
	CameraManager.add_target(hitbox)
	
	player.global_position = start.global_position
	#camera.camera2d.limit_left = camera_min_point.global_position.x
	#camera.camera2d.limit_right = camera_max_point.global_position.x
	#camera.camera2d.limit_top = camera_min_point.global_position.y
	#camera.camera2d.limit_bottom = camera_max_point.global_position.y
	camera.global_position = player.global_position

func _enter_tree() -> void:
	if (is_node_ready()):
		_initialize()
	
func _ready() -> void:
	_initialize()
	
func _unhandled_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("admin_9") && hitbox != null):
		hitbox.queue_free()

func _exit_tree() -> void:
	ObjectManager.giveup("Player", player)
	ObjectManager.giveup("Camera", camera)
	CameraManager.remove_target(hitbox)
