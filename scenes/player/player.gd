extends CharacterBody2D

@export var speed = 400
@onready var animated_sprite_2d = $AnimatedSprite2D

var direction = 'down';
var character_state = '_idle'
var attack_mode = false


func _physics_process(delta):
	get_input()
	
	move_and_slide()
	
	set_character_movement_animation()


func set_character_movement_animation():
	
	if not attack_mode:
		if velocity == Vector2.ZERO: character_state = '_idle'
		else: character_state = '_movement'
			
	if velocity.x < -1 or velocity.x > 1: direction = 'side'
	if velocity.y < -1: direction = 'up'
	if velocity.y > 1: direction = 'down'
		
	if velocity.x > 1: animated_sprite_2d.flip_h = false
	elif velocity.x < -1: animated_sprite_2d.flip_h = true
	
	animated_sprite_2d.animation = direction + character_state


func get_input():
	if Input.is_action_pressed("ui_accept"):
		attack_mode = true
		character_state = '_attack'
		velocity = Vector2.ZERO
	elif Input.is_action_just_released('ui_accept'):
		attack_mode = false
	else:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_direction * speed
