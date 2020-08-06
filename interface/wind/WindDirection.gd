extends CenterContainer

onready var arrow = $Arrow
var wind_direction = Vector2(1,0)
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	arrow.set_rotation(deg2rad(95));
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x = rng.randf_range(-0.1,0.1)
	var y = rng.randf_range(-0.1,0.1)
	wind_direction += Vector2(x*delta*10,y*delta*10)
	if wind_direction.length() > 1:
		wind_direction = wind_direction.normalized()
	arrow.set_rotation(wind_direction.angle() + deg2rad(90))
	arrow.rect_scale.x = wind_direction.length()
	arrow.rect_scale.y = wind_direction.length()
	
