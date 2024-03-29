extends Control

var current_page

@onready var spell_name_1 = $MarginContainer/Page1/Spell1/SpellName
@onready var spell_image_1 = $"MarginContainer/Page1/Spell1/SpellImage"
@onready var spell_description_1 = $MarginContainer/Page1/Spell1/SpellDescription
@onready var spell_name_2 = $MarginContainer2/Page2/Spell2/SpellName
@onready var spell_image_2 = $"MarginContainer2/Page2/Spell2/SpellImage"
@onready var spell_description_2 = $MarginContainer2/Page2/Spell2/SpellDescription


# Called when the node enters the scene tree for the first time.
func _ready():
	current_page = 1
	update_pages(current_page)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_pages(current_page):
	if current_page == 1:
		spell_name_1.text = "Heal"
		spell_image_1.texture = preload("res://images/spellbook/heal.png")
		spell_description_1.text = "Slightly heals target. Use it when someone is at low health."
		spell_name_2.text = "Rain"
		spell_image_2.texture = preload("res://images/spellbook/rain.png")
		spell_description_2.text = "Calls down light showers upon target. Use when someone is on fire."
	if current_page == 2:
		spell_name_1.text = "Cure"
		spell_image_1.texture = preload("res://images/spellbook/cure.png")
		spell_description_1.text = "Purges poison from targets body. Use it when someone is suffering from poison."
		spell_name_2.text = "Defrost"
		spell_image_2.texture = preload("res://images/spellbook/defrost.png")
		spell_description_2.text = "Warms up the target. Use it when someone is frozen solid."

func _on_next_button_pressed():
	if current_page < 2:
		current_page += 1
		update_pages(current_page)
		SoundPlayer.play_sound(SoundPlayer.PAGE)


func _on_back_button_pressed():
	if current_page > 1:
		current_page -= 1
		update_pages(current_page)
		SoundPlayer.play_sound(SoundPlayer.PAGE)
