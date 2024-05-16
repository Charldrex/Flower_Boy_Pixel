extends CanvasLayer


# RECOLECTA MONEDAS
func _ready():
	$cointcount.text = "score: " + str(Global.coinscollected)

	
	
	
func _process(delta):
	$lives.text = "Lives: " + str(Global.player_lives)
	$cointcount.text = "Coins: " + str(Global.coinscollected)

	
	
