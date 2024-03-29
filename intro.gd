extends Node2D


func boss_landed():
	SoundPlayer.play_sound(SoundPlayer.BASICATTACK)

func time_to_fight():
	SoundPlayer.play_sound(SoundPlayer.SHIELD)


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://game.tscn")
