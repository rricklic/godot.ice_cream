extends Node

# Autoload ScreenShaderManager

signal signal_transition_start
signal signal_transition_end

################################################################################
# Description: Controls shaders operating on the entire screen
################################################################################

func start(shaders: Array[ScreenShaderBase]) -> void:
	signal_transition_start.emit()
	
	var temps: Array[CanvasItem] = []

	var tweens: Array[Tween]
	for shader: ScreenShaderBase in shaders:
		add_child(shader)
		var backbuffer: BackBufferCopy = _create_backbuffer()
		var texture_rect: TextureRect = _create_shader_rect(shader)
		get_tree().root.add_child.call_deferred(backbuffer)
		get_tree().root.add_child.call_deferred(texture_rect)
		temps.push_back(backbuffer)
		temps.push_back(texture_rect)
		tweens.push_back(shader.start())
		
	for tween: Tween in tweens:
		await tween.finished

	for temp: CanvasItem in temps:
		temp.queue_free()
		
	for shader: ScreenShaderBase in shaders:
		shader.queue_free()
		
	shaders.clear()
	
	signal_transition_end.emit()

func _create_backbuffer() -> BackBufferCopy:
	var back_buffer_copy: BackBufferCopy = BackBufferCopy.new()
	back_buffer_copy.copy_mode = BackBufferCopy.COPY_MODE_VIEWPORT
	return back_buffer_copy

func _create_shader_rect(shader: ScreenShaderBase) -> TextureRect:
	var shaderMaterial: ShaderMaterial = shader.get_shader_material()
	var texture_rect = TextureRect.new()
	texture_rect.anchors_preset = Control.LayoutPreset.PRESET_FULL_RECT
	texture_rect.size = get_tree().root.content_scale_size
	texture_rect.texture = PlaceholderTexture2D.new()
	texture_rect.material = shaderMaterial
	return texture_rect;
