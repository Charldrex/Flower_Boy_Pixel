extends Area2D

@onready var game_manager_1 = $"../../GameManager1"
@onready var animation_player = $AnimationPlayer



func _on_body_entered(body):
	Global.coinscollected +=1
	game_manager_1.add_point()
	animation_player.play("pickup")
