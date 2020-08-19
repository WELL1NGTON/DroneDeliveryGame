extends Control

var data = {
	"music_volume" : 0,
	"sound_effects" : 0
}

func _ready():
	var loaded_data = $SaveLoad.load()
	if loaded_data != null:
		data = loaded_data
	$MarginContainer/VBoxContainer/MainMusic/MarginContainer/MainMusicSlider.value = data["music_volume"]
	$MarginContainer/VBoxContainer/SoundsEffects/MarginContainer/SoundEffectSlider.value = data["sound_effects"]

func _on_Button_pressed():
	$SaveLoad.save(data)
	get_tree().change_scene("res://main_menu/MainMenu.tscn") # Replace with function body.

func _on_Button2_toggled(button_pressed):
	if button_pressed == true:
		$MainMusic.play()
	if button_pressed == false:
		$MainMusic.stop()
		 
				


func _on_SoundEffect1_pressed():
	$SoundEffect1.play()# Replace with function body.


func _on_SoundEffect2_pressed():
	$SoundEffect2.play()
	# Replace with function body.
	
func _on_MainMusicSlider_value_changed(value):
	data["music_volume"] = value
	AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1), value, 0.5))
	if value == -30:
		AudioServer.set_bus_mute(1,true)
	else:
		AudioServer.set_bus_mute(1, false)
		


func _on_SoundEffectSlider_value_changed(value):
	data["sound_effects"] = value
	AudioServer.set_bus_volume_db(2, lerp(AudioServer.get_bus_volume_db(2), value, 0.5))
	if value == -30:
		AudioServer.set_bus_mute(2,true)
	else:
		AudioServer.set_bus_mute(2, false)
	# Replace with function body.
