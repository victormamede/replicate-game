extends Node3D

@onready var _interactor: Interactor = $Actor/Forward/Interactor
@onready var _forward: Node3D = $Actor/Forward
@onready var _actor: Actor = $Actor

var rotation_buff: Vector3 = Vector3.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_interactor.initialize(_actor)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var motion := event as InputEventMouseMotion
		rotation_buff += - Vector3(motion.relative.y, motion.relative.x, 0.0) * 0.001
	
	if event.is_action_pressed('action_1'):
		_interactor.interact()
	
	if event.is_action_pressed('jump'):
		_actor.jump()

func _process(_delta: float) -> void:
	var input_dir := Input.get_vector('move_left', 'move_right', 'move_forward', 'move_backward')
	_actor.move_dir = _forward.transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)

func _physics_process(_delta: float) -> void:
	_forward.rotation += rotation_buff
	rotation_buff = Vector3.ZERO