extends Node

@onready var sound_effect_players = $SoundEffectPlayers

const ATTACK1 = preload("res://sounds/attack1.wav")
const ATTACK2 = preload("res://sounds/attack2.wav")
const ATTACK3 = preload("res://sounds/attack3.wav")
const ATTACK4 = preload("res://sounds/attack4.wav")
const ATTACK5 = preload("res://sounds/attack5.wav")
const ATTACK_SOUNDS = [ATTACK2, ATTACK3, ATTACK4, ATTACK5]
const THUD = preload("res://sounds/thud.wav")

const CAST = preload("res://sounds/cast.wav")
const CURE = preload("res://sounds/cure.wav")
const FIZZLE = preload("res://sounds/fizzle.wav")
const HEAL = preload("res://sounds/heal.wav")
const MAGIC1 = preload("res://sounds/magic1.wav")
const RAIN = preload("res://sounds/rain.wav")
const SHIELD = preload("res://sounds/shield.wav")

const FIREATTACK = preload("res://sounds/fireattack.wav")
const POISONATTACK = preload("res://sounds/poisonattack.wav")
const BASICATTACK = preload("res://sounds/basicattack.wav")

func play_sound(sound):
	for audioStreamPlayer in sound_effect_players.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break

func play_attack_sound():
	play_sound(ATTACK_SOUNDS.pick_random())
