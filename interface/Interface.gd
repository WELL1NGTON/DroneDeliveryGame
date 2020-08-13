extends Control

func _ready():
	pass # Replace with function body.

func _process(_delta):
	rect_size = get_tree().get_root().get_viewport().size * get_parent().zoom
	rect_position = rect_size*-0.5
	pass
