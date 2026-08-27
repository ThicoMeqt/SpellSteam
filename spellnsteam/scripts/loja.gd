extends Control

@onready var icons = [
	$TextureRect/icon_toalha,
	$TextureRect/icon_cerca1,
	$TextureRect/icon_cerca2
]
@onready var labels = [
	$TextureRect/icon_toalha/lbl_toalha,
	$TextureRect/icon_cerca1/lbl_cerca1,
	$TextureRect/icon_cerca2/lbl_cerca2
]
@onready var btns = [
	$TextureRect/icon_toalha/btn_toalha,
	$TextureRect/icon_cerca1/btn_cerca1,
	$TextureRect/icon_cerca2/btn_cerca2
]
@onready var name_label = $Panel/MarginContainer/VBoxContainer/Label
@onready var text_label = $Panel/MarginContainer/VBoxContainer/RichTextLabel
@onready var npc_sprite = $Sprite2D
@onready var btn_comprar = $TextureRect/btn_comprar
@onready var popup = $popup
@onready var popuptext = $popup/popup/Label
var item_preco = ["1X carvão   1X ação", "1X madeira 1X ação", "3X madeira 1X ação"]
var current_item = 3
var text_fail = "Recursos Insuficientes."
var text_success = "Upgrade comprado com sucesso!"
var original_scale: Vector2
var dialogue_lines = []
var current_line = 0
var text_speed = 0.02
var is_typing = false
var full_text_shown = false
var full_text_toalha = [
		"Toalhas macias e confortáveis, perfeitas para relaxar depois de uma boa sauna. Um pequeno detalhe que torna a experiência muito mais aconchegante e agradável."]
var full_text_cerca1 = [
		"Cercas simples feitas de madeira resistente. Além de dar um toque mais rústico à sauna, ajudam a deixá-la mais aconchegante e bem cuidada."]
var full_text_cerca2 = [
		"Um conjunto adicional de cercas. Não queria muito vendê-lo, mas por um bom preço podemos negociar."]
var full_text_start = [
		"Seja muito bem vindo(a)! Vendo itens úteis em troca de alguns materiais. Sinta-se em casa e fique a vontade para olhar em volta."]
var full_text_arigathanks = [
		"Muito obrigado pela preferência!"]

func _ready():
	original_scale = npc_sprite.scale
	name_label.text = "Lojista"
	$TextureRect/Label4/Label3.text = ""
	btn_comprar.disabled = true
	start_dialogue(full_text_start)
	GameManager.update_loja.connect(update_loja)
	update_loja()

func update_loja():
	icons[0].self_modulate.a = 0.5 if GameManager.itens_comprados["toalha"] == true else 1.0
	btns[0].disabled = true if GameManager.itens_comprados["toalha"] == true else false
	icons[1].self_modulate.a = 0.5 if GameManager.itens_comprados["cerca1"] == true else 1.0
	btns[1].disabled = true if GameManager.itens_comprados["cerca1"] == true else false
	icons[2].self_modulate.a = 0.5 if GameManager.itens_comprados["cerca2"] == true else 1.0
	btns[2].disabled = true if GameManager.itens_comprados["cerca2"] == true else false

#==========================================================================
#animação e diálogo
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
	await get_tree().create_timer(1).timeout
	current_line = 0

#==========================================================================
#comprar
func buy_toalha():
	if GameManager.inventory["carvao"] < 1 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["carvao"] -= 1
	GameManager.add_item("up_toalha")
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	GameManager.itens_comprados["toalha"] = true
	success()
func buy_cerca1():
	if GameManager.inventory["madeira"] < 1 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["madeira"] -= 1
	GameManager.add_item("up_cerca")
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	GameManager.itens_comprados["cerca1"] = true
	success()
func buy_cerca2():
	if GameManager.inventory["madeira"] < 3 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["madeira"] -= 3
	GameManager.add_item("up_cerca")
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	GameManager.itens_comprados["cerca2"] = true
	success()

func _on_btn_toalha_pressed() -> void:
	if current_item != 0:
		start_dialogue(full_text_toalha)
		btn_comprar.disabled = false
		$TextureRect/Label4/Label3.text = item_preco[0]
		current_item = 0
	elif current_item == 0:
		current_item = 3
		start_dialogue(full_text_start)
		btn_comprar.disabled = true
		$TextureRect/Label4/Label3.text = ""
func _on_btn_cerca_1_pressed() -> void:
	if current_item != 1:
		start_dialogue(full_text_cerca1)
		btn_comprar.disabled = false
		$TextureRect/Label4/Label3.text = item_preco[1]
		current_item = 1
	elif current_item == 1:
		current_item = 3
		start_dialogue(full_text_start)
		btn_comprar.disabled = true
		$TextureRect/Label4/Label3.text = ""
func _on_btn_cerca_2_pressed() -> void:
	if current_item != 2:
		start_dialogue(full_text_cerca2)
		btn_comprar.disabled = false
		$TextureRect/Label4/Label3.text = item_preco[2]
		current_item = 2
	elif current_item == 2:
		current_item = 3
		start_dialogue(full_text_start)
		btn_comprar.disabled = true
		$TextureRect/Label4/Label3.text = ""

func _on_button_pressed() -> void:	
	popup.visible = false
func fail():
	popup.visible = true
	popuptext.text = str(text_fail)
func success():
	popup.visible = true
	popuptext.text = str(text_success)

func _on_btn_comprar_pressed() -> void:
	if current_item == 0:
		buy_toalha()
		current_item = 3
	elif current_item == 1:
		buy_cerca1()
		current_item = 3
	elif current_item == 2:
		buy_cerca2()
		current_item = 3
	elif current_item == 3:
		return
	update_loja()
	start_dialogue(full_text_arigathanks)
	$TextureRect/Label4/Label3.text = ""

func _on_btn_fechar_pressed() -> void:
	GameManager.player_enable = true
	$".".visible = false
