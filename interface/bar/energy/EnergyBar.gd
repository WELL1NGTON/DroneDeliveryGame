extends HBoxContainer

var energy
var battery_drain = 0.5

onready var energy_label = $EnergyCounter/Label
onready var energy_bar = $TextureProgress

func _ready():
	energy = 100
	energy_label.text = str(int(energy)) + "/100"
	energy_bar.value = energy
	pass # Replace with function body.

func _process(delta):
	energy -= battery_drain * delta
	if energy < 0:
		energy = 100
	energy_label.text = str(int(energy)) + "/100"
	energy_bar.value = energy
	
