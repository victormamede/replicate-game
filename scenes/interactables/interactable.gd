class_name Interactable
extends Area3D

signal interacted(interactor: Interactor)

func interact(interactor: Interactor) -> void:
	monitorable = false
	interacted.emit(interactor)
