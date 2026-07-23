extends ColorRect

@onready var info_sauna = $"."
@onready var nome_sauna = $caixa_info/label_nome
@onready var desc_sauna = $caixa_info/label_info
@onready var lvl_conf = $caixa_info/nivel_conf
@onready var lvl_agua = $caixa_info/nivel_agua
@onready var lvl_pop = $caixa_info/nivel_pop

func _ready() -> void:
	info_sauna.visible = false
	cont_conf = [
	lvl_conf.get_node("ColorRect"),
	lvl_conf.get_node("ColorRect2"),
	lvl_conf.get_node("ColorRect3"),
	lvl_conf.get_node("ColorRect4"),
	lvl_conf.get_node("ColorRect5")]
	cont_agua = [
	lvl_agua.get_node("ColorRect"),
	lvl_agua.get_node("ColorRect2"),
	lvl_agua.get_node("ColorRect3"),
	lvl_agua.get_node("ColorRect4"),
	lvl_agua.get_node("ColorRect5")]
	cont_pop = [
	lvl_pop.get_node("ColorRect"),
	lvl_pop.get_node("ColorRect2"),
	lvl_pop.get_node("ColorRect3"),
	lvl_pop.get_node("ColorRect4"),
	lvl_pop.get_node("ColorRect5")]

var cont_conf = []
var cont_agua = []
var cont_pop = []

var nomes_sauna = ["A sua sauna","sauna1","sauna2","sauna3"]
var desc_saunas = [
	"    A sua sauna. A melhor sauna de todas, a única liderada por um golbin safado (você).",
	"sauna1fds sauna1fds sauna1fds sauna1fds sauna1fds sauna1fds sauna1fds sauna1fds sauna1fds sauna1fds sauna1fds sauna1fds ",
	"sauna2fds sauna2fds sauna2fds sauna2fds sauna2fds sauna2fds sauna2fds sauna2fds sauna2fds sauna2fds sauna2fds sauna2fds ",
	"sauna3fds sauna3fds sauna3fds sauna3fds sauna3fds sauna3fds sauna3fds sauna3fds sauna3fds sauna3fds sauna3fds sauna3fds "]


func open_info_sauna(num, c, w, p):
	nome_sauna.text = nomes_sauna[num]
	desc_sauna.text = desc_saunas[num]
	info_sauna.visible = true
	GameManager.player_mov = false
	for i in range (cont_conf.size()):
		if i < c:
			cont_conf[i].color = Color(0.902, 0.902, 0.902, 0.522)
		else:
			cont_conf[i].color = Color(0.0, 0.0, 0.0, 0.522)
	for i in range (cont_agua.size()):
		if i < w:
			cont_agua[i].color = Color(0.902, 0.902, 0.902, 0.522)
		else:
			cont_agua[i].color = Color(0.0, 0.0, 0.0, 0.522)
	for i in range (cont_pop.size()):
		if i < p:
			cont_pop[i].color = Color(0.902, 0.902, 0.902, 0.522)
		else:
			cont_pop[i].color = Color(0.0, 0.0, 0.0, 0.522)

func _on_btn_info_sauna_pressed() -> void:
	open_info_sauna(0, GameManager.sp_comfort, GameManager.sp_water, GameManager.sp_popularity)
func _on_btn_info_sauna_2_pressed() -> void:
	open_info_sauna(1, GameManager.sr1_comfort, GameManager.sr1_water, GameManager.sr1_popularity)
func _on_btn_info_sauna_3_pressed() -> void:
	open_info_sauna(2, GameManager.sr2_comfort, GameManager.sr2_water, GameManager.sr2_popularity)
func _on_btn_info_sauna_4_pressed() -> void:
	open_info_sauna(3, GameManager.sr3_comfort, GameManager.sr3_water, GameManager.sr3_popularity)

func _on_btn_fechar_sauna_pressed() -> void:
	info_sauna.visible = false
	GameManager.player_mov = true
