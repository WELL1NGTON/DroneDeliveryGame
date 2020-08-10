extends KinematicBody2D

var energy = 100
var acceleration = Vector2()
var motion = Vector2()
const MAX_SPEED = 30
const BATTERY_DRAIN = 50

onready var energy_label = get_node("./Camera2D/Interface/EnergyBar/EnergyCounter/Label")
onready var energy_bar = get_node("./Camera2D/Interface/EnergyBar/TextureProgress")
onready var timer_label = get_node("./Camera2D/Interface/TimerLabel")

var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_attributes()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	acceleration *= 0.9
#	acceleration = get_node("./Camera2D/Interface/WindDirection").wind_speed + get_node("./Camera2D/Interface/Analog").stick_speed
	motion += motion*(-0.005)
	motion += (get_node("./Camera2D/Interface/Analog").stick_vector * get_node("./Camera2D/Interface/Analog").stick_speed * 2 + get_node("./Camera2D/Interface/WindDirection").wind_direction * get_node("./Camera2D/Interface/WindDirection").wind_speed * 0.5) * delta
	if motion.length() > MAX_SPEED:
		motion = motion.normalized()
		motion = motion*MAX_SPEED
#	speed += acceleration
#	speed = min(speed,MAX_SPEED)
#	direction = direction.normalized()
	

	move_and_slide(motion*20)
#	position += motion
#	position += get_node("./Camera2D/Interface/Analog").stick_vector * get_node("./Camera2D/Interface/Analog").stick_speed * 2 * delta
	energy -= BATTERY_DRAIN * delta
	if energy < 0:
		energy = 100
	energy_label.text = str(int(energy)) + "/100"
	energy_bar.value = energy
	
	timer += delta
	timer_label.text = str(int(timer))
	
func reset_attributes():
	energy_label.text = str(int(energy)) + "/100"
	energy_bar.value = energy
	motion = Vector2.ZERO
