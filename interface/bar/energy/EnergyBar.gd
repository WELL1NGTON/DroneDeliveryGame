extends HBoxContainer

signal game_over

var energy
var battery_drain = 1
var battery_charge_rate = 3
var player = null

onready var energy_label = $EnergyCounter/Label
onready var energy_bar = $TextureProgress
onready var drone_game = get_tree().get_root().get_node("./DroneGame")


func _ready():
	energy = 100
	energy_label.text = str(int(energy)) + "/100"
	energy_bar.value = energy
	player = get_tree().get_root().get_node_or_null("./DroneGame/Player")
	self.connect("game_over", drone_game, "game_over")

func _process(delta):
	
	if player != null:
		if player.is_charging:
			energy += battery_charge_rate * delta
		else:
			energy -= battery_drain * delta
		
		if energy <= 0:
			energy = 0
			emit_signal("game_over")
			self.disconnect("game_over", drone_game, "game_over")
			set_process(false)
		elif energy > 100:
			energy = 100
			
		energy_label.text = str(int(energy)) + "/100"
		energy_bar.value = energy
	else:
		player = get_tree().get_root().get_node_or_null("./DroneGame/Player")
