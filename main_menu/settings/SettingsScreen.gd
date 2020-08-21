extends Control

var data = {
	"music_volume" : 0,
	"sound_effects" : 0
}

func _ready():
	var loaded_data = $SaveLoad.load()
	if loaded_data != null:
		data = loaded_data
	$MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/MainMusic/MarginContainer/MainMusicSlider.value = data["music_volume"]
	$MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/SoundsEffects/MarginContainer/SoundEffectSlider.value = data["sound_effects"]





func _on_BackButton_pressed():
	$SaveLoad.save(data)
	get_tree().change_scene("res://main_menu/MainMenu.tscn") # Replace with function body.
	


func _on_SoundEffectSlider_value_changed(value):
	data["sound_effects"] = value # Replace with function body.


func _on_MainMusicSlider_value_changed(value):
	data["music_volume"] = value # Replace with function body.
