extends Node3D

const FollowBehavior := preload ('res://scenes/actors/behaviors/follow.gd')

@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _actor: Actor = $Actor
@onready var _model: Node3D = $Actor/Model
@onready var _follow_behaviror: FollowBehavior = $FollowBehavior

var _is_following := false

func _process(_delta: float) -> void:
	if !_is_following:
		return

	if _actor.move_dir.is_zero_approx():
		_animation_player.speed_scale = 1.0
		_animation_player.current_animation = "animations/Idle"
	else:
		_animation_player.speed_scale = _actor.speed
		_animation_player.current_animation = "animations/Walk"

	if not _actor.move_dir.is_zero_approx():
		_model.global_basis = Basis.looking_at( - _actor.move_dir)

func _on_interactable_interacted(interactor: Interactor) -> void:
	if _is_following:
		_follow_behaviror.stop_following()
		_animation_player.speed_scale = 1.0
		_is_following = false
		_animation_player.play("animations/Talk")
		await _animation_player.animation_finished
	else:
		_animation_player.play("animations/Talk")
		await _animation_player.animation_finished
		_is_following = true
		_follow_behaviror.set_following(interactor.get_actor())