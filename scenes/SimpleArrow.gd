extends Area2D


#using this insteady of _ready() because of instantiations 
func _enter_tree():
	var PlayerNode = get_tree().get_root().get_node("./DroneGame/Player")
#	print("post office connected")
	self.connect("body_entered",PlayerNode,"entered_objective", [self])
