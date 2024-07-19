class_name Actor
extends CharacterBody3D

@export var speed := 5.0
@export var acceleration := 30.0
@export var jump_velocity := 4.5
@export var gravity := 20.0

var move_dir := Vector3.ZERO

func _physics_process(delta: float) -> void:
	var velocity_y := velocity.y
	
	if not is_on_floor():
		velocity_y -= gravity * delta

	var direction := Vector3(move_dir.x, 0, move_dir.z).normalized()
	velocity = velocity.move_toward(direction * speed, delta * acceleration * speed)
	velocity.y = velocity_y

	move_and_slide()

func jump() -> void:
	if is_on_floor():
		velocity.y = jump_velocity
