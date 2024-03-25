extends VBoxContainer

var status_effect = "none"

@export var party_member := "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.text = party_member

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func healed(spell_name):
	if spell_name == "heal":
		# heal animation
		$HealthBar.value += $HealthBar.max_value * 0.5
	if spell_name == "rain":
		# wet animation
		if status_effect == "on fire":
			status_effect = "none"

func attacked(attack_name):
	if attack_name == "fire":
		status_effect = "on fire"

func _on_button_pressed():
	get_parent().get_parent().get_parent().get_parent().change_target(self)


func _on_timer_timeout():
	if status_effect != "none":
		$HealthBar.value -= 1
