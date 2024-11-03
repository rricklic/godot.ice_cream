class_name TransitionColorFadeShader extends Transition

var color: Color
var start_amount: float
var end_amount: float
var duration: float

func _init(color: Color, start_amount: float, end_amount: float, duration: float):
	self.color = color
	self.start_amount = start_amount
	self.end_amount = end_amount
	self.duration = duration

func perform(node: Node2D) -> void:
	pass
	# TODO:
	#await ScreenShaderManager.start([ShaderColorFade.new(color, start_amount, end_amount, duration)])
