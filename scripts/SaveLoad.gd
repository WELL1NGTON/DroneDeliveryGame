extends Node

const SAVE_DIR = "user://user_saves/"
export var save_path = SAVE_DIR + "settings.dat"

func save(data):
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()
	
func load():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var data = file.get_var()
			file.close()
			return data
	return null
