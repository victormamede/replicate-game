class_name HUD
extends Control

@onready var crosshair: Control = %Crosshair

func _ready() -> void:
	crosshair.visible = false

func _on_interactor_interactable_unfocused(_interactable: Interactable) -> void:
	crosshair.visible = false

func _on_interactor_interactable_focused(_interactable: Interactable) -> void:
	crosshair.visible = true
