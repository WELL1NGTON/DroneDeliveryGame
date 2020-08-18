extends KinematicBody2D

signal delivery_completed
var acceleration = Vector2.ZERO
var motion = Vector2.ZERO
var is_charging = false
var is_holding_package = false
var invulnerable = false
const MAX_SPEED = 30
onready var sparkParticles = get_node("DroneAnimatedSprite/SparkParticles")
onready var chargingParticles = get_node("DroneAnimatedSprite/ChargingParticles")
onready var deliveryParticles = get_node("DroneAnimatedSprite/DeliveryParticles")
onready var deliverySound = $DeliverySound
onready var chargingSound = $ChargingSound

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_attributes()
	self.connect("delivery_completed", get_parent(), "package_delivered")
	self.connect("delivery_completed", $Camera2D/Interface/DeliveriesCounter, "package_delivered")


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

func reset_attributes():
	var energy_bar = get_node_or_null("./Camera2D/Interface/EnergyBar")
	energy_bar.energy = 100
	var timer = get_node_or_null("./Camera2D/Interface/TimerLabel")
	timer.timer = 60
	acceleration = Vector2.ZERO
	motion = Vector2.ZERO
	is_charging = false
#	get_node("./Camera2D/Interface/Analog")

func entered_post_office(_body):
	if _body == self:
		is_charging = true
		chargingParticles.emitting = true
		chargingSound.play()
		if is_holding_package == false:
			is_holding_package = true
			$DroneAnimatedSprite/PackageSprite.visible = true
			get_parent().new_objective()

func exited_post_office(_body):
	if _body == self:
		is_charging = false
		chargingSound.stop()
		chargingParticles.emitting = false

func entered_objective(_body, simple_arrow : Node):
	if _body == self:
		if is_holding_package == true:
			is_holding_package = false
			$DroneAnimatedSprite/PackageSprite.visible = false
			emit_signal("delivery_completed", simple_arrow)
			deliveryParticles.emitting = true
			deliverySound.play()
			get_parent().package_delivered(simple_arrow)

func hit_bird(_body):
	if _body == self && invulnerable == false:
		invulnerable = true
		$ImpactSound.play(0)
		$GotHitTimer.start(1)
		$DroneAnimatedSprite/ShockAnimatedSprite.visible = true
		$Camera2D/Interface/EnergyBar.energy -= 10
		sparkParticles.emitting = true

func _on_GotHitTimer_timeout():
	$DroneAnimatedSprite/ShockAnimatedSprite.visible = false
	invulnerable = false

