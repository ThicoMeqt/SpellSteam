extends Control

@onready var fade = $ColorRect
@onready var txtbox_nome = $play/TextEdit
@onready var txtbox_sauna = $play/TextEdit2
@onready var lbl_erro_nome = $play/TextEdit/Label
@onready var lbl_erro_sauna = $play/TextEdit2/Label

func _ready() -> void:
	lbl_erro_nome.visible = false
	lbl_erro_sauna.visible = false

func _on_play_pressed() -> void:
	var nome_limpo = str(txtbox_nome.text.replace(" ",""))
	var sauna_limpo = str(txtbox_sauna.text.replace(" ",""))
	var tamanho_nome = nome_limpo.length()
	var tamanho_sauna = sauna_limpo.length()
	if nome_limpo == "":
		lbl_erro_nome.text = "Insira seu Nome antes de inicar."
		lbl_erro_nome.visible = true
		return
	elif tamanho_nome < 3:
		lbl_erro_nome.text = "O nome dever ter no mínimo 3 caracteres."
		lbl_erro_nome.visible = true
		return
	elif tamanho_nome > 20:
		lbl_erro_nome.text = "O nome dever ter no máixmo 20 caracteres."
		lbl_erro_nome.visible = true
		return
	else:
		lbl_erro_nome.visible = false
	if sauna_limpo == "":
		lbl_erro_sauna.text = "Insira seu Nome antes de inicar."
		lbl_erro_sauna.visible = true
		return
	elif tamanho_sauna < 5:
		lbl_erro_sauna.text = "O nome dever ter no mínimo 5 caracteres."
		lbl_erro_sauna.visible = true
		return
	elif tamanho_sauna > 20:
		lbl_erro_sauna.text = "O nome dever ter no máixmo 20 caracteres."
		lbl_erro_sauna.visible = true
		return
	else:
		lbl_erro_sauna.visible = false
	GameManager.player_name = txtbox_nome.text.strip_edges()
	GameManager.sauna0_nome = txtbox_sauna.text.strip_edges()
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, 1.0)
	tween.finished.connect(func ():
		get_tree().change_scene_to_file("res://scenes/main.tscn"))

func _on_quit_pressed() -> void:
	get_tree().quit()
