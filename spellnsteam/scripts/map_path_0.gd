extends Node2D

@onready var btn_abrir = $btn_abrir_quadro
@onready var btn_fechar = $painel_avisos/textura_avisos/ColorRect2/btn_fechar_avisos
@onready var painel = $painel_avisos

func _ready() -> void:
	painel.visible = false
	btn_fechar.disabled = true

func _on_btn_abrir_quadro_pressed() -> void:
	painel.visible = true
	btn_fechar.disabled = false
	GameManager.player_enable = false

func _on_btn_fechar_avisos_pressed() -> void:
	painel.visible = false
	btn_fechar.disabled = true
	GameManager.player_enable = true
