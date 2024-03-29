extends Control

func _ready():
	SoundPlayer.play_music(SoundPlayer.AMBIENCE)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://intro.tscn")

func _on_exit_pressed():
	get_tree().quit()
