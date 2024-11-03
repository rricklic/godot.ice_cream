class_name ShaderColorFade extends ScreenShaderBase

const SHADER: Shader = preload("res://shaders/screen/color_fade.gdshader")
var color: Color
var start_amount: float
var end_amount: float
var duration: float
var shader_material: ShaderMaterial

func _init(color: Color, start_amount: float, end_amount: float, duration: float) -> void:
	self.color = color
	self.start_amount = start_amount
	self.end_amount = end_amount
	self.duration = duration
	shader_material = create_shader_material(SHADER)
	shader_material.set_shader_parameter("target_color", color)
	shader_material.set_shader_parameter("amount", start_amount)
	
func get_shader_material() -> ShaderMaterial:
	return shader_material

func start() -> Tween:
	var tween: Tween = create_tween()
	tween.tween_method(_set_amount.bind(shader_material), start_amount, end_amount, duration)
	return tween

func _set_amount(amount: float, shader_material: ShaderMaterial) -> void:
	shader_material.set_shader_parameter("amount", amount)
