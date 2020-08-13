extends Label

var timer = 60

func _ready():
	pass # Replace with function body.

func _process(delta):
	timer -= delta
	self.text = str(int(timer))
