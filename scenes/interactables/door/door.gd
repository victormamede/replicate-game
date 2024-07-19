extends Node3D

const Door = preload ('res://scenes/props/door/door.gd')

@onready var door: Door = $Door

func _on_interactable_interacted(_interactor: Interactor) -> void:
	door.close() if door.is_open() else door.open()