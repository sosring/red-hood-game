extends CharacterBody2D

@export var speed = 400
@onready var animated_sprite_2d = $AnimatedSprite2D
var direction = 'down';

func set_character_movement_animation():
	if velocity == Vector2.ZERO: animated_sprite_2d.animation = direction + '_idle'
	else:
		if velocity.x < -1 or velocity.x > 1: direction = 'side'
		if velocity.y < -1: direction = 'up'
		if velocity.y > 1: direction = 'down'
		
		animated_sprite_2d.animation = direction + '_movement'
		
	print(velocity.x)
	#animated_sprite_2d.flip_h = true if velocity.x < -1 else false
	if velocity.x > 1: animated_sprite_2d.flip_h = false
	elif velocity.x < -1: animated_sprite_2d.flip_h = true

func get_input():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT): 
		print(direction  + '_attack')
		velocity = Vector2.ZERO
		animated_sprite_2d.animation = direction  + '_attack'
	else:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_direction * speed
	

func _physics_process(delta):
	get_input()
	
	move_and_slide()
	
	set_character_movement_animation()
