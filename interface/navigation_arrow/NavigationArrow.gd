extends CenterContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var objective_position = get_tree().get_root().get_node("./DroneGame/Objective").position
	var player_position = get_tree().get_root().get_node("./DroneGame/Player").position
#	print(objective_position)
#	print(player_position)
#	print(player_position.angle_to_point(objective_position))
	
	self.rect_rotation = rad2deg(Vector2(1,0).angle_to_point(objective_position - (player_position + Vector2(0,-300)))) + 90
	pass
