extends NinePatchRect

var points = 0

func reset_points():
	points = 0
	$Label.text = str(points)
	
func add_point():
	points += 1
	$Label.text = str(points)

func package_delivered(simple_arrow : Node):
	add_point()
