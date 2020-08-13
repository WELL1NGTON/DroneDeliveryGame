extends Area2D

#func _process(_delta):
#	if get_overlapping_bodies().size() > 0:
#		print(get_overlapping_bodies())
#	pass

#using this insteady of _ready() because of instantiations 
func _enter_tree():
	var PlayerNode = get_tree().get_root().get_node("./DroneGame/Player")
#	print("post office connected")
	self.connect("body_entered",PlayerNode,"entered_post_office")
	self.connect("body_exited",PlayerNode,"exited_post_office")

