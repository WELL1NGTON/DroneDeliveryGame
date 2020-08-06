extends TextureRect

const CIRCLES_SCALE = 3
const EXTERNAL_RADIUS = 64 * CIRCLES_SCALE
const INTERNAL_RADIUS = 32 * CIRCLES_SCALE

export(Vector2) var stick_pos
var evt_index = -1



func _init():
#	CIRCLES_SCALE = $ExternalArea.global_scale.x
#	EXTERNAL_RADIUS = 64 * CIRCLES_SCALE
#	INTERNAL_RADIUS = 32 * CIRCLES_SCALE
	stick_pos = position

	
func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			if stick_pos.distance_to(event.position) < EXTERNAL_RADIUS * CIRCLES_SCALE:
				evt_index = event.index
		elif evt_index != -1:
			if evt_index == event.index:
				evt_index = -1
				$InternalArea.position = Vector2()
				$"../".stick_vector = Vector2()
				$"../".stick_angle = 0
				$"../".stick_speed = 0

	if evt_index != -1 and event is InputEventScreenDrag:
		var dist = (stick_pos).distance_to(event.position)
		if dist + INTERNAL_RADIUS > EXTERNAL_RADIUS:
			dist = EXTERNAL_RADIUS - INTERNAL_RADIUS
		var vect = (event.position - stick_pos).normalized()
		
		var ang = event.position.angle_to_point(stick_pos)
		$"../".stick_vector = vect
		$"../".stick_angle = ang
		$"../".stick_speed = dist
		
		$InternalArea.position = vect * dist / CIRCLES_SCALE
		
