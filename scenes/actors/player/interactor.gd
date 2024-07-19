class_name Interactor
extends RayCast3D

signal interactable_focused(interactable: Interactable)
signal interactable_unfocused(interactable: Interactable)

var focused_interactable: Interactable:
	set(value):
		if value == focused_interactable:
			return
		
		if focused_interactable:
			interactable_unfocused.emit(focused_interactable)

		if value:
			interactable_focused.emit(value)
		
		focused_interactable = value

var _actor: Actor

func initialize(actor: Actor) -> void:
	_actor = actor

func _physics_process(_delta: float) -> void:
	if !is_colliding():
		focused_interactable = null
		return

	var collider := get_collider()
	focused_interactable = collider as Interactable

func interact() -> void:
	if focused_interactable:
		focused_interactable.interact(self)

func get_actor() -> Actor:
	return _actor