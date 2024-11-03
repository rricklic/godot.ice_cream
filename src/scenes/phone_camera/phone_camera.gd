class_name PhoneCamera extends Node2D

var is_rotated: bool = false

@onready var sub_viewport_2: SubViewport = $SubViewport2
@onready var camera_2d_2: Camera2D = $SubViewport2/Camera2D2

@onready var phone_case: Sprite2D = $PhoneCase
@onready var screen: Sprite2D = $Screen
@onready var shutter: Polygon2D = $Shutter
@onready var tween: Tween = null

@onready var photo: Sprite2D = $Photo

func _ready() -> void:
	sub_viewport_2.world_2d = get_tree().root.get_viewport().world_2d

func _physics_process(delta: float) -> void:
	var pos: Vector2 = get_global_mouse_position()
	phone_case.global_position = lerp(phone_case.global_position, pos, 0.25)
	shutter.global_position = lerp(shutter.global_position, pos, 0.25)
	camera_2d_2.global_position = lerp(camera_2d_2.global_position, pos, 0.25)
	screen.global_position = lerp(camera_2d_2.global_position, pos, 0.25)

func _unhandled_input(event: InputEvent) -> void:
	if (Input.is_action_pressed("mouse_wheel_up")):
		camera_2d_2.zoom += Vector2(0.1, 0.1)
		camera_2d_2.zoom = clamp(camera_2d_2.zoom, Vector2(1, 1), Vector2(5, 5))
	if (Input.is_action_pressed("mouse_wheel_down")):
		camera_2d_2.zoom -= Vector2(0.1, 0.1)
		camera_2d_2.zoom = clamp(camera_2d_2.zoom, Vector2(1, 1), Vector2(5, 5))
	if (Input.is_action_just_pressed("mouse_left_click")):
		shutter.visible = true
		var timer: SceneTreeTimer = get_tree().create_timer(0.1, true)
		await timer.timeout
		await RenderingServer.frame_post_draw
		shutter.visible = false
		
		var image: Image = sub_viewport_2.get_texture().get_image()
		if (is_rotated):
			image.rotate_90(CLOCKWISE)
		photo.texture = ImageTexture.new().create_from_image(image)
			
	# TODO: buffer rotation if close to end of tween
	if (Input.is_action_just_pressed("mouse_right_click") && tween == null):
		tween = create_tween()
		var target_angle: float = 0 if is_rotated else 90
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.set_parallel(true)
		tween.tween_property(phone_case, "rotation_degrees", target_angle, 1.0)
		tween.tween_property(shutter, "rotation_degrees", target_angle, 1.0)
		tween.tween_property(screen, "rotation_degrees", target_angle, 1.0)
		tween.tween_property(camera_2d_2, "rotation_degrees", target_angle, 1.0)
		await tween.finished
		tween = null
		is_rotated = !is_rotated
