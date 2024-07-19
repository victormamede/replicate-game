extends OmniLight3D

@export var flicker_time := 0.02
@export var flicker := 0.0

@onready var _initial_energy := light_energy

var _flicker_timer_buffer := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_zero_approx(flicker):
		return

	_flicker_timer_buffer += delta
	while _flicker_timer_buffer > flicker_time:
		light_energy = randf_range(_initial_energy - flicker, _initial_energy + flicker)
		_flicker_timer_buffer -= flicker_time
