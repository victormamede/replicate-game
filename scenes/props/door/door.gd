extends Node3D

@onready var _body: Node3D = $StaticBody3D

var _tween: Tween
var _opened := false

func open() -> void:
	if _opened:
		return

	if _tween != null:
		_tween.stop()

	_opened = true
	_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	_tween.tween_property(_body, "rotation", Vector3(0.0, PI / 2, 0.0), 1.0)

func close() -> void:
	if not _opened:
		return

	if _tween != null:
		_tween.stop()

	_opened = false
	_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	_tween.tween_property(_body, "rotation", Vector3(0.0, 0.0, 0.0), 1.0)

func is_open() -> bool:
	return _opened