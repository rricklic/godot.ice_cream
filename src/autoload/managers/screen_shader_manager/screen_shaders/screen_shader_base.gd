class_name ScreenShaderBase extends Node
	
func get_shader_material() -> ShaderMaterial:
	return null

func start() -> Tween:
	return null

func create_shader_material(shader: Shader) -> ShaderMaterial:
	var shader_material: ShaderMaterial = ShaderMaterial.new()
	shader_material.shader = shader
	shader_material.resource_local_to_scene = true
	return shader_material;
