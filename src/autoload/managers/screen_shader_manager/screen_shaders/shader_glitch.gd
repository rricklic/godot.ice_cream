class_name ShaderGlitch extends ScreenShaderBase

const SHADER: Shader = preload("res://shaders/screen/glitch.gdshader")
var shake_power: float = 0.03;
var shake_rate: float = 0.2;
var shake_speed: float = 5.0;
var shake_block_size: float = 30.5;
var shake_color_rate: float = 0.01;
var duration: float
var shader_material: ShaderMaterial

func _init(duration: float) -> void:
	self.duration = duration
	shader_material = create_shader_material(SHADER)
	shader_material.set_shader_parameter("shake_power", shake_power)
	shader_material.set_shader_parameter("shake_rate", shake_rate)
	shader_material.set_shader_parameter("shake_speed", shake_speed)
	shader_material.set_shader_parameter("shake_block_size", shake_block_size)
	shader_material.set_shader_parameter("shake_color_rate", shake_color_rate)

func get_shader_material() -> ShaderMaterial:
	return shader_material

func start() -> Tween:
	var tween: Tween = create_tween()
	tween.tween_method(_set_shake_power.bind(shader_material), shake_power, shake_power, duration)
	return tween

func _set_shake_power(shake_power: float, shader_material: ShaderMaterial) -> void:
	shader_material.set_shader_parameter("shake_power", shake_power)
