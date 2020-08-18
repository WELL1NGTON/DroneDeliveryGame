extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
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
	AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1), value, 0.5))
	if value == -30:
		AudioServer.set_bus_mute(1,true)
	else:
		AudioServer.set_bus_mute(1, false)
		


func _on_SoundEffectSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, lerp(AudioServer.get_bus_volume_db(2), value, 0.5))
	if value == -30:
		AudioServer.set_bus_mute(2,true)
	else:
		AudioServer.set_bus_mute(2, false)
	# Replace with function body.
