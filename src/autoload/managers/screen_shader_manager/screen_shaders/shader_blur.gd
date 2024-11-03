class_name ShaderBlur extends ScreenShaderBase

const SHADER: Shader = preload("res://shaders/screen/blur.gdshader")
var start_intensity: float
var end_intensity: float
var duration: float
var shader_material: ShaderMaterial

func _init(start_intensity: float, end_intensity: float, duration: float) -> void:
	self.start_intensity = start_intensity
	self.end_intensity = end_intensity
	self.duration = duration
	shader_material = create_shader_material(SHADER)
	shader_material.set_shader_parameter("intensity", start_intensity)
	
func get_shader_material() -> ShaderMaterial:
	return shader_material

func start() -> Tween:
	var tween: Tween = create_tween()
	tween.tween_method(_set_intensity.bind(shader_material), start_intensity, end_intensity, duration)
	return tween

func _set_intensity(intensity: float, shader_material: ShaderMaterial) -> void:
	shader_material.set_shader_parameter("intensity", intensity)
