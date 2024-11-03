class_name Frog extends CharacterBody2D

# short hops
# high jumps
# bouncing while idle

@export_category("Jump Parameters")
 ## Maximum height of jump in pixels
@export var jump_max_height: float = 25.0
 ## Time to peak of jump in seconds
@export var jump_time_peak: float = 0.2
## Time to land after reaching peak of jump in seconds
@export var jump_time_land: float = 0.1

@export_category("Movement Parameters")
@export var hop_speed: float = 25.0
@export var hide_speed: float = 200.0

@onready var _jump_velocity = JumpUtil.calc_jump_velocity(jump_max_height, jump_time_peak)
@onready var _jump_gravity = JumpUtil.calc_jump_gravity(jump_max_height, jump_time_peak)
@onready var _fall_gravity = JumpUtil.calc_fall_gravity(jump_max_height, jump_time_land)

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if (!is_on_floor()):
		velocity.y += _get_gravity() * delta

	#if (Input.is_action_just_pressed("p1_button_1") && is_on_floor()):
	#	velocity.y = _jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction_x := Input.get_axis("p1_left", "p1_right")
	#if direction_x:
	#	velocity.x = direction_x * speed
	#else:
	#	velocity.x = move_toward(velocity.x, 0, speed)

	#var direction_y := Input.get_axis("p1_up", "p1_down")

	#if (direction_x || direction_y):
	#	CameraManager.set_target_offset(Vector2(direction_x, direction_y) * Vector2(100.0, 50.0))


	move_and_slide()

func _get_gravity() -> float:
	return _jump_gravity if (velocity.y < 0.0) else _fall_gravity

func _handle_hurt(area: Area2D) -> void:
	CameraManager.apply_trauma(20)

