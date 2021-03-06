extends Path2D

# https://www.youtube.com/watch?v=_lJ0jbahbjw

onready var follow = get_node("PathFollow2D")

var tween

func _ready():
	set_process(true)
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(follow, "unit_offset",
								0, 1, 6,
								tween.TRANS_LINEAR,
								tween.EASE_IN_OUT)
	tween.set_repeat(true)
	tween.start()
