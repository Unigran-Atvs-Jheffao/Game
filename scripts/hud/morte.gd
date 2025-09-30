extends Control


func _on_button_button_up() -> void:
	visible = false;
	GlobalPlayerData.init();
	WaveData.init();
	get_tree().paused = false;
	get_tree().reload_current_scene();
	pass # Replace with function body.


func _on_button_visibility_changed() -> void:
	if(visible):
		get_tree().paused = true;
