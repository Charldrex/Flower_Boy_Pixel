extends Node2D

const SPEED = 60
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
	
var direction = 1
var is_alive = true

func _ready():
	add_to_group("Enemy")

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta
	
# KILL ENEMIGO
func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		is_alive = false
		die()

func die():
	animated_sprite.play("die")
	await move_player_up_and_down()
	
func move_player_up_and_down():
	var start_position = position
	var down_position = start_position + Vector2(0, 500)	
	
	while position.y < down_position.y:
		position.y += 1
		await get_tree().create_timer(0.01).timeout
		
