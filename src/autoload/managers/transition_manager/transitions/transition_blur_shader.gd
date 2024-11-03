class_name TransitionBlurShader extends Transition

var start_amount: float
var end_amount: float
var duration: float

func _init(start_amount: float, end_amount: float, duration: float):
	self.start_amount = start_amount
	self.end_amount = end_amount
	self.duration = duration

func perform(node: Node2D) -> void:
	pass
	# TODO:
	#await ScreenShaderManager.start([ShaderBlur.new(start_amount, end_amount, duration)])
