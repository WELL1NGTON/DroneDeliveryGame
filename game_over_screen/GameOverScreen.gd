extends Control

#var scene_path_to_load

func _ready():
	var return_main_menu = $CenterContainer/VBoxContainer/ReturnMainMenu
	return_main_menu.connect("pressed", self, "_on_Button_Pressed", [return_main_menu.scene_to_load])

func _on_Button_Pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)
