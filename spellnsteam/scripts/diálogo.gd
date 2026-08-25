extends Control

@onready var name_label = $Panel/MarginContainer/VBoxContainer/Label
@onready var text_label = $Panel/MarginContainer/VBoxContainer/RichTextLabel
@onready var npc_sprite = $Sprite2D
var original_scale: Vector2
var dialogue_lines = []
var current_line = 0
var text_speed = 0.02
var is_typing = false
var full_text_shown = false
var full_text_sabotar = [
		"Ainda está muito cedo e têm muitas pessoas por perto. Tentar algo agora seria muito arriscado.", 
		"Acho que devo voltar aqui mais tarde e tentar novamente quando a área estiver vazia."]
var full_text_floresta = [
		"A floresta fica cheia de criaturas durante a noite.", 
		"Acho que devo voltar aqui amanhã quando estiver mais claro."]


func _ready():
	GameManager.dialogo_sabotar_start.connect(comecar_sabotar)
	GameManager.dialogo_floresta_start.connect(comecar_floresta)
	original_scale = npc_sprite.scale
	name_label.text = GameManager.player_name

func comecar_sabotar():
	start_dialogue(full_text_sabotar)

func comecar_floresta():
	start_dialogue(full_text_floresta)

func play_squash():
	if npc_sprite == null:
		return
	var tween = create_tween()
	npc_sprite.scale = Vector2(original_scale.x * 1.2, original_scale.y * 0.8)
	tween.tween_property(npc_sprite, "scale", original_scale, 0.20)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)

func micro_squash():
	if npc_sprite == null:
		return
	npc_sprite.scale = original_scale
	var tween = create_tween()
	tween.tween_property(npc_sprite, "scale", Vector2(original_scale.x * 1.02, original_scale.y * 0.98), 0.04)
	tween.tween_property(npc_sprite, "scale", original_scale, 0.07)

func start_dialogue(lines:Array):
	$Panel.visible = true
	dialogue_lines = lines
	current_line = 0
	show_line()

func show_line():
	play_squash()
	text_label.text = dialogue_lines[current_line]
	text_label.visible_characters = 0
	is_typing = true
	full_text_shown = false
	await get_tree().process_frame
	type_text()

func type_text():
	while text_label.visible_characters < text_label.get_total_character_count():
		text_label.visible_characters += 1
		var idx = text_label.visible_characters - 1
		@warning_ignore("shadowed_global_identifier")
		var char = text_label.text[idx]
		if char == " " or char in [",", ".", "!", "?"]:
			micro_squash()
		await get_tree().create_timer(text_speed).timeout
	is_typing = false
	full_text_shown = true

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		handle_advance()

func handle_advance():
	if is_typing:
		text_label.visible_characters = text_label.get_total_character_count()
		is_typing = false
		full_text_shown = true
		return
	if full_text_shown:
		current_line += 1
		if current_line >= dialogue_lines.size():
			end_dialogue()
		else:
			show_line()

func end_dialogue():
	await get_tree().create_timer(0.5).timeout
	current_line = 0
	GameManager.dialogo_sabotar_end.emit()
