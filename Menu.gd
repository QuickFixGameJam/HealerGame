extends Control

func _ready():
	SoundPlayer.play_music(SoundPlayer.AMBIENCE)

func _on_play_pressed():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://intro.tscn")

func _on_exit_pressed():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	get_tree().quit()
