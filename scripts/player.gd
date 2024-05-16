extends CharacterBody2D

var is_dying = false
var is_jumping = false

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var death_timer = $death_timer

func _ready():
	add_to_group("Player")
	death_timer.connect("timeout", Callable(self, "_on_DeathTimer_timeout"))

func _physics_process(delta):
	if is_dying:
		return	
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else: 
		is_jumping = false
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	update_animation(direction)
	move_and_slide()
	
	# MOVERLO DE DIRECCION 
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# ANIMACIONES
func update_animation(direction):
	if is_dying:
		return
		
	if is_jumping:
		animated_sprite.play("jump")
	elif direction !=0:
		animated_sprite.flip_h = (direction < 0)
		animated_sprite.play("run")
	else: 
		animated_sprite.play("idle")
	

# DEAD PLAYER
func _on_hitbox_body_entered(body):
	if body.is_in_group("Enemy") and body.is_alive:
		die()
		
func die():
	if is_dying:
		return
		
	is_dying = true
	animated_sprite.play("die")
	await move_player_up_and_down()
	
		
		
func move_player_up_and_down():
	var start_position = position
	var up_position = start_position + Vector2(0, -50)
	var down_position = start_position + Vector2(0, 500)	
	
	while position.y > up_position.y:
		position.y -= 3
		await get_tree().create_timer(0.01).timeout
		
	while position.y < down_position.y:
		position.y += 3
		await get_tree().create_timer(0.01).timeout
			
func on_DeathTimer_timeout():	
	get_tree().reload_current_scene()
		
		
