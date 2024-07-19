extends Node

@export var actor: Actor
@export var navigation_agent: NavigationAgent3D

@export_group("Configuration")
@export var turn_speed := 5.0
@export var recalculate_distance := 2.0

var _actor_forward := Vector3.ZERO
var _following: Node3D

func _ready() -> void:
	_actor_forward = actor.move_dir

func _physics_process(delta: float) -> void:
	if _following == null:
		return
	
	if navigation_agent.is_navigation_finished():
		actor.move_dir = Vector3.ZERO
	else:
		var current_agent_position := actor.global_position
		var next_path_position := navigation_agent.get_next_path_position()
		var move_direction := current_agent_position.direction_to(next_path_position)
		move_direction.y = 0.0
		_actor_forward = _actor_forward.slerp(move_direction, delta * turn_speed)
		actor.move_dir = _actor_forward
	
	if _following.global_position.distance_to(navigation_agent.target_position) > recalculate_distance:
		navigation_agent.target_position = _following.global_position

	navigation_agent.velocity = actor.velocity

func set_following(target: Node3D) -> void:
	_following = target
	navigation_agent.target_position = _following.global_position

func stop_following() -> void:
	actor.move_dir = Vector3.ZERO
	_following = null

func is_following() -> bool:
	return _following != null