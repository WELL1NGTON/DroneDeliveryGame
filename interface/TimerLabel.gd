extends Label

signal game_over

onready var drone_game = get_tree().get_root().get_node("./DroneGame")
var timer = 60

func _ready():
	self.connect("game_over", drone_game, "game_over")

func _process(delta):
	timer -= delta
	self.text = str(int(timer))
	if timer <= 0:
		emit_signal("game_over")
		self.disconnect("game_over", drone_game, "game_over")
		set_process(false)
