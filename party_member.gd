extends VBoxContainer

var status_effect = " "
var dead := false
var rng = RandomNumberGenerator.new()

@export var party_member := " "

@onready var default_color = $Button.self_modulate
@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $AttackAnimationPlayer
@onready var status_animation_player = $StatusAnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready():
	$Character/Sprite2D/Label.text = status_effect
	rng.randomize()
	$AttackTimer.wait_time = rng.randi_range(2, 9)
	$AttackTimer.start()
	
	set_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		status_effect == "dead"

func healed(spell_name):
	if dead == false and status_effect != "dead":
		if spell_name == "heal":
			SoundPlayer.play_sound(SoundPlayer.HEAL)
			# heal animation
			if status_effect != "dead": $HealthBar.value += $HealthBar.max_value * 0.5
		if spell_name == "rain":
			SoundPlayer.play_sound(SoundPlayer.RAIN)
			# wet animation
			if status_effect == "on fire":
				$Character/Sprite2D/Fire.emitting=false
				status_effect = " "
		if spell_name == "cure":
			SoundPlayer.play_sound(SoundPlayer.CURE)
			# cure animation
			if status_effect == "poisoned":
				$Character/Sprite2D/Poison.emitting=false
				status_effect = " "
		if spell_name == "defrost":
			SoundPlayer.play_sound(SoundPlayer.DEFROST)
			# defrost animation
			if status_effect == "frozen":
				$Character/Sprite2D/Freeze.emitting=false
				status_animation_player.play("frozen")
				status_animation_player.stop()
				status_effect = " "
	if spell_name == "heal":
		SoundPlayer.play_sound(SoundPlayer.HEAL)
		$Character/Sprite2D/Heal.emitting=true
		# heal animation
		if status_effect != "dead": $HealthBar.value += $HealthBar.max_value * 0.5
	if spell_name == "rain":
		SoundPlayer.play_sound(SoundPlayer.RAIN)
		$Character/Sprite2D/Cloud.emitting=true
		$Character/Sprite2D/Rain.emitting=true
		# wet animation
		if status_effect == "on fire":
			$Character/Sprite2D/Fire.emitting=false
			status_effect = " "
	if spell_name == "cure":
		SoundPlayer.play_sound(SoundPlayer.CURE)
		$Character/Sprite2D/Cure.emitting=true
		# cure animation
		if status_effect == "poisoned":
			$Character/Sprite2D/Poison.emitting=false
			status_effect = " "
	if spell_name == "defrost":
		SoundPlayer.play_sound(SoundPlayer.DEFROST)
		$Character/Sprite2D/Defrost.emitting=true
		# defrost animation
		if status_effect == "frozen":
			$Character/Sprite2D/Freeze.emitting=false
			status_animation_player.play("frozen")
			status_animation_player.stop()
			status_effect = " "
	
	$Character/Sprite2D/Label.text = status_effect
	if status_effect == " ": 
		$Button.self_modulate = default_color

func attacked(attack_name):
	if dead == false and status_effect != "dead":
		if attack_name == "fire":
			$Character/Sprite2D/Fire.emitting=true
			status_effect = "on fire"
			$Button.self_modulate = Color8(255, 50, 50)
			SoundPlayer.play_sound(SoundPlayer.FIREATTACK)
		elif attack_name == "poison":
			$Character/Sprite2D/Poison.emitting=true
			status_effect = "poisoned"
			$Button.self_modulate = Color8(50, 255, 50)
			SoundPlayer.play_sound(SoundPlayer.POISONATTACK)
		elif attack_name == "basic":
			SoundPlayer.play_sound(SoundPlayer.BASICATTACK)
			if status_effect != " ":
				$HealthBar.value -= 45
			else:
				$HealthBar.value -= 20
		elif attack_name == "freeze":
			$Character/Sprite2D/Freeze.emitting=true
			status_effect = "frozen"
			$Button.self_modulate = Color8(50, 255, 255)
			SoundPlayer.play_sound(SoundPlayer.FREEZEATTACK)
			status_animation_player.play("frozen")
		$Character/Sprite2D/Label.text = status_effect

func set_sprite():
	if party_member == "Balthazar":
		$Character/Sprite2D.texture = preload("res://images/balthazar.png")
		$Button.icon = preload("res://images/iconsb.png")
	elif party_member == "Tapeworm":
		$Character/Sprite2D.texture = preload("res://images/tapeworm.png")
		$Button.icon = preload("res://images/iconst.png")
	elif party_member == "Scotty Potty":
		$Character/Sprite2D.texture = preload("res://images/archer.png")
		$Button.icon = preload("res://images/iconss.png")
	elif party_member == "Knife Rat":
		$Character/Sprite2D.texture = preload("res://images/rat.png")
		$Button.icon = preload("res://images/iconsr.png")
	elif party_member == "Spellbook":
		$Character/Sprite2D.texture = null
		$Button.icon = preload("res://images/iconspellbook.png")
	else:
		$Character/Sprite2D.texture = preload("res://images/balthazar.png")

func attack_sound():
	SoundPlayer.play_attack_sound()

func _on_button_pressed():
	get_parent().get_parent().get_parent().get_parent().change_target(self)


func _on_timer_timeout():
	if status_effect != " " and status_effect != "dead":
		$HealthBar.value -= 2
	if $HealthBar.value <= 0:
		status_effect = "dead"
		$Button.self_modulate = Color8(255, 255, 255, 100)
		animation_player.play("dead")
		$Timer.stop()
		SoundPlayer.play_sound(SoundPlayer.THUD)
		status_animation_player.stop()
		$Character/Sprite2D/Fire.emitting=false
		$Character/Sprite2D/Poison.emitting=false
		$Character/Sprite2D/Freeze.emitting=false
		$Character/Sprite2D.texture = preload("res://images/grave.png")
		dead = true
		get_parent().get_parent().get_parent().get_parent().party_member_dead(self)
	$Character/Sprite2D/Label.text = status_effect


func _on_attack_timer_timeout():
	if status_effect != "dead":
		animation_player_2.play("attack")
		await animation_player_2.animation_finished
		get_parent().get_parent().get_parent().get_parent().attack_boss()
		$AttackTimer.wait_time = rng.randi_range(2, 9)
