class_name JumpUtil extends Object

static func calc_jump_velocity(jump_max_height: float, jump_time_peak: float) -> float:
	return (2.0 * jump_max_height) / jump_time_peak * -1.0

static func calc_jump_gravity(jump_max_height: float, jump_time_peak: float) -> float:
	return -(2.0 * jump_max_height) / (jump_time_peak * jump_time_peak) * -1.0
	
static func calc_fall_gravity(jump_max_height: float, jump_time_land: float) -> float:
	return -(2.0 * jump_max_height) / (jump_time_land * jump_time_land) * -1.0
