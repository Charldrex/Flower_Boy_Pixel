extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	# MUERE EL JUGADOR
	if body.is_in_group("Player"):
		body.die()
	print("you died")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()
	

func _on_timer_timeout():
	Engine.time_scale = 1.0
	# VIDA DEL JUGADOR
	Global.player_lives -= 1	
	if Global.player_lives > 0:
		print("Killme")		
		get_tree().reload_current_scene()
	else:
		Global.coinscollected = 0
		Global.score = 0
		Global.player_lives += 3	
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		


