extends CharacterBody2D

const GRAVITY = 500.0
const JUMP_FORCE = -300.0
const MOVE_SPEED = 100.0


func _process(delta):
	velocity.y += GRAVITY * delta
#	var player = get_node("/root/Game/Node2D/Player")
#	if player:
#		var direction = (player.global_position - global_position).normalized()

#		velocity.x = direction.x * MOVE_SPEED
	#	velocity.y = JUMP_FORCE
#		$AnimatedSprite.play("Jumping")
	#	$AnimatedSprite.flip_h = direction.x < 0

#	else:
#		velocity.x = 0
#		$AnimatedSprite.play("Idle")
