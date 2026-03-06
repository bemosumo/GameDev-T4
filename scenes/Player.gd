extends CharacterBody2D

@export var speed: int = 400
@export var gravity: int = 1200
@export var jump_speed: int = -400
@export var max_jumps: int = 2
var jump_count: int = 0

func get_input():
	velocity.x = 0
	
	if is_on_floor():
		jump_count = 0
		
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
		velocity.y = jump_speed
		jump_count += 1
		
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed

func _physics_process(delta):
	velocity.y += delta * gravity
	get_input()
	move_and_slide()

func _process(_delta):
	if not is_on_floor():
		$Animator.play("Jump")
	elif velocity.x != 0:
		$Animator.play("Walk")
	else:
		$Animator.play("Idle")

	if velocity.x != 0:
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
