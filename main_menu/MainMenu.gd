extends Control

var scene_path_to_load

func _ready():
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_Pressed", [button.scene_to_load])
	$AdMob.load_banner()

func _on_Button_Pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	$AdMob.hide_banner()
	get_tree().change_scene(scene_path_to_load)
