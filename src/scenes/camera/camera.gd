class_name Camera extends Node2D

################################################################################
# Description: 
#   Features:
#     debug mode: user control position, zoom, rotation
#     screen shake
#     trauma areas
#     follow target(s) snap, smooth follow
#     look ahead, behind, above, below
################################################################################

# TODO: dead zone
# TODO: boundaries

"""
const init_camera_rotation: float = 0.0

signal signal_add_camera_target(node2D: Node2D)
signal signal_remove_camera_target(node2D: Node2D)
signal signal_set_camera_target(node2D: Node2D)
signal signal_clear_camera_targets(node2D: Node2D)

@export_category("Shake configuration")
@export var camera_trauma_data: CameraTraumaData

@export_category("Debug movment")
@export var camera_move_speed: float = 200.0
@export var camera_rotation_speed: float = 100.0

#Shake data
var trauma: float = 0.0 # range(0.0, 1.0)
var time: float = 0.0

var targets: Dictionary

@onready var trauma_detect_area: Area2D = $TraumaDetectArea

@onready var camera: Camera2D = $Camera2D
@onready var init_camera_position: Vector2 = camera.position

"""
@export var camera_trauma_data: CameraTraumaData = CameraTraumaData.new()
@export var zoom_margin: Vector2 = Vector2(200, 200)
@export_range(0.1, 10) var follow_smoothing: float = 5.0

var is_debug: bool = false
var targets: Dictionary
var target_offset: Vector2 = Vector2.ZERO

var trauma: float = 0.0
var time: float = 0.0

@onready var noise: FastNoiseLite = camera_trauma_data.noise
@onready var noise_speed: float = camera_trauma_data.noise_speed
@onready var max_x: float = camera_trauma_data.max_x
@onready var max_y: float = camera_trauma_data.max_y
@onready var max_r: float = camera_trauma_data.max_r
@onready var trauma_recovery: float = camera_trauma_data.recovery
@onready var trauma_detect_area: Area2D = $TraumaDetectArea
@onready var camera2d: Camera2D = $Camera2D

func _ready() -> void:
	#trauma_detect_area.area_entered.connect(_on_trauma_detected)
	pass

func add_target(node: Node2D) -> void:
	targets[node.get_instance_id()] = node

func remove_if_target_deleted(node: Node2D) -> void:
	if (node.is_queued_for_deletion()):
		remove_target(node)

func remove_target(node2D: Node2D) -> void:
	targets.erase(node2D.get_instance_id())

func clear_targets() -> void:
	targets.clear()

func _process(delta: float) -> void:
	_handle_shake(delta)

func _handle_shake(delta: float) -> void:
	time += delta
	trauma = max(trauma - delta * trauma_recovery, 0.0) # TODO: comment out if want constant shake (like handheld camera)
	var shake_intensity: float = _calc_shake_intensity()
	camera2d.position.x = max_x * shake_intensity * _get_noise_from_seed(0)
	camera2d.position.y = max_y * shake_intensity * _get_noise_from_seed(1)
	camera2d.rotation_degrees = max_r * shake_intensity * _get_noise_from_seed(2)
	if (trauma <= 0):
		set_process(false)

func set_target_offset(vector: Vector2) -> void:
	#target_offset = vector
	pass

# Called in sync with frame rate (1/60th second), so delta should be constant
func _physics_process(delta: float) -> void:
	if (is_debug):
		_handle_debug_movement(delta)
	else:
		_handle_target_movement(delta)

	# TODO: apply boundry limits

func _handle_zoom(min_pos: Vector2, max_pos: Vector2, delta: float) -> void:
	var screen_size: Vector2 = get_viewport_rect().size # TODO: get_viewport_size
	var calc_zoom: Vector2 = (max_pos - min_pos + zoom_margin) / screen_size
	var target_zoom: float = 1 / max(calc_zoom.x, calc_zoom.y, 1)
	camera2d.zoom = lerp(camera2d.zoom, Vector2(target_zoom, target_zoom), delta * follow_smoothing)

func _handle_target_movement(delta: float) -> void:
	if (targets.values().size() == 0):
		return
	
	var min_pos: Vector2 = targets.values()[0].global_position #+ target_offset
	var max_pos: Vector2 = targets.values()[0].global_position #+ target_offset
	for target: Node2D in targets.values():
		var target_position: Vector2 = target.global_position #+ target_offset
		min_pos = Vector2(min(min_pos.x, target_position.x), min(min_pos.y, target_position.y))
		max_pos = Vector2(max(max_pos.x, target_position.x), max(max_pos.y, target_position.y))

	var center: Vector2 = (max_pos + min_pos) / 2.0
	global_position = lerp(global_position, center, delta * follow_smoothing)

	_handle_zoom(min_pos, max_pos, delta)

func _handle_debug_movement(delta: float) -> void:
	const rotation_speed: float = 50.0
	const move_speed: float = 200.0
	
	var v = Input.get_axis("admin_1", "admin_2")
	var h = Input.get_axis("admin_3", "admin_4")
	var r = Input.get_axis("admin_5", "admin_6")
	var z = Input.get_axis("admin_7", "admin_8")
	global_position += Vector2(h, v) * move_speed * delta
	rotation_degrees += r * rotation_speed * delta
	camera2d.zoom += Vector2(z, z) * 5 * delta

func _unhandled_input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("admin_0")):
		is_debug = !is_debug

func _get_noise_from_seed(seed: int) -> float:
	noise.seed = seed
	return noise.get_noise_1d(Time.get_ticks_msec() * noise_speed) # TODO: use Time.get_ticks_msec()?

func _calc_shake_intensity() -> float:
	return trauma * trauma

"""
func _on_trauma_detected(area2D: Area2D) -> void:
	if (area2D is CameraTraumaArea):
		var traumaArea: CameraTraumaArea = area2D
		apply_trauma(traumaArea.amount)
"""

func apply_trauma(amount: float) -> void:
	trauma = clamp(trauma + amount, 0.0, 1.0)
	set_process(true)
	
#func _draw() -> void:
	#draw_circle(global_position, 100, Color.RED)
	#print(global_position)
	#draw_circle(position, 100, Color.BLUE)
	#print(position)
