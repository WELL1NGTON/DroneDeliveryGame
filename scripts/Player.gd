extends KinematicBody2D


var acceleration = Vector2()
var motion = Vector2()
const MAX_SPEED = 30

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
	timer += delta
	timer_label.text = str(int(timer))
	
func reset_attributes():
	var energy_bar = get_node_or_null("./Camera2D/Interface/EnergyBar")
	energy_bar.energy = 100
	
	motion = Vector2.ZERO
	
#	get_node("./Camera2D/Interface/Analog")
