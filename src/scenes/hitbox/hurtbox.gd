class_name Hurtbox extends Area2D

################################################################################
# Description: 
################################################################################

signal signal_hurt(hitBox: Hitbox)
signal signal_hurt_stop(hitBox: Hitbox)

@export var actor: Node2D
@export var cooloff_time: float = 0.5

var hitboxes: Array[Hitbox]

func _ready() -> void:
	area_entered.connect(_hitbox_entered)
	area_exited.connect(_hitbox_exited)

func _hitbox_entered(area: Area2D) -> void:
	if (area is Hitbox):
		var hitbox: Hitbox = area
		hitboxes.push_back(hitbox)
		_handle_hitbox()
		
func _hitbox_exited(area: Area2D) -> void:
	if (area is Hitbox):
		var hitbox: Hitbox = area
		hitboxes.erase(hitbox)
		hitbox.stop_action(actor)
		signal_hurt_stop.emit(hitbox)
		
func _handle_hitbox() -> void:
	if (hitboxes.is_empty()):
		return
	hitboxes[0].perform_action(actor)
	signal_hurt.emit(hitboxes[0])
	get_tree().create_timer(cooloff_time, false).timeout.connect(_handle_hitbox)
