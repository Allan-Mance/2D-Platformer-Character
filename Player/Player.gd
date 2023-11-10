extends CharacterBody2D

@onready var SM = $StateMachine

var jump_power = Vector2.ZERO
var direction = 1

@export var gravity = Vector2(0,30)

@export var move_speed = 20
@export var max_move = 300

@export var jump_speed = 200
@export var max_jump = 1200

@export var leap_speed = 200
@export var max_leap = 1200

var Jump_Sound = null
var Coin_Sound = null
var Run_Sound = null

var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite


func _physics_process(_delta):
	velocity.x = clamp(velocity.x,-max_move,max_move)
		
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite2D.flip_h: $AnimatedSprite2D.flip_h = true
		if direction > 0 and $AnimatedSprite2D.flip_h: $AnimatedSprite2D.flip_h = false
	
	if is_on_floor():
		double_jumped = false
		set_wall_raycasts(true)

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		Run_Sound = get_node_or_null("/root/Game/Run_Sound")
		if Run_Sound != null:
			Run_Sound.play()
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1
	if Input.is_action_pressed("jump"):
		if Jump_Sound != null:
			Jump_Sound.play()

func set_animation(anim):
	if $AnimatedSprite2D.animation == anim: return
	if $AnimatedSprite2D.sprite_frames.has_animation(anim): $AnimatedSprite2D.play(anim)
	else: $AnimatedSprite2D.play()

func is_on_right_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func is_on_left_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func get_right_collider():
	return $Wall/Right.get_collider()

func get_left_collider():
	return $Wall/Left.get_collider()
	
func set_wall_raycasts(is_enabled):
	$Wall/Left.enabled = is_enabled
	$Wall/Right.enabled = is_enabled

func die():
	queue_free()
	


func _on_coin_collector_body_entered(body):
	if body.name == "Coins":
		body.get_coin(global_position)
		Coin_Sound = get_node_or_null("/root/Game/Coin_Sound")
		if Coin_Sound != null:
			Coin_Sound.play()
