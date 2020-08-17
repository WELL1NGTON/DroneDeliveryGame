extends Area2D

func _ready():
	var PlayerNode = get_tree().get_root().get_node("./DroneGame/Player")
	self.connect("body_entered",PlayerNode,"hit_bird")
