extends Control

@onready var lvl_conf = $status/nivel_conf
@onready var lvl_agua = $status/nivel_agua
@onready var lvl_pop = $status/nivel_pop
@onready var lbl_pontos = $resultado/Label/lbl_pontos
@onready var class_saunas = [
	$resultado/Label2/VBoxContainer/lbl_colocacao1,
	$resultado/Label2/VBoxContainer/lbl_colocacao2,
	$resultado/Label2/VBoxContainer/lbl_colocacao3,
	$resultado/Label2/VBoxContainer/lbl_colocacao4
]
var cont_conf = []
var cont_agua = []
var cont_pop = []
var nomes_sauna = [GameManager.sauna0_nome, GameManager.sauna1_nome, GameManager.sauna2_nome, GameManager.sauna3_nome]

func _ready() -> void:
	def_conts()
	update_stats()
	clas()
	lbl_pontos.text = str(pontos(GameManager.sauna_stats["confort"], GameManager.sauna_stats["water"], GameManager.sauna_stats["popularity"]))

func def_conts():
	cont_conf = [
	lvl_conf.get_node("ColorRect"),
	lvl_conf.get_node("ColorRect2"),
	lvl_conf.get_node("ColorRect3"),
	lvl_conf.get_node("ColorRect4")]
	cont_agua = [
	lvl_agua.get_node("ColorRect"),
	lvl_agua.get_node("ColorRect2"),
	lvl_agua.get_node("ColorRect3")]
	cont_pop = [
	lvl_pop.get_node("ColorRect"),
	lvl_pop.get_node("ColorRect2"),
	lvl_pop.get_node("ColorRect3"),
	lvl_pop.get_node("ColorRect4"),
	lvl_pop.get_node("ColorRect5")]

func update_stats():
	for i in range (cont_conf.size()):
		if i < GameManager.sauna_stats["confort"]:
			cont_conf[i].color = Color(0.902, 0.902, 0.902, 0.522)
		else:
			cont_conf[i].color = Color(0.0, 0.0, 0.0, 0.522)
	for i in range (cont_agua.size()):
		if i < GameManager.sauna_stats["water"]:
			cont_agua[i].color = Color(0.902, 0.902, 0.902, 0.522)
		else:
			cont_agua[i].color = Color(0.0, 0.0, 0.0, 0.522)
	for i in range (cont_pop.size()):
		if i < GameManager.sauna_stats["popularity"]:
			cont_pop[i].color = Color(0.902, 0.902, 0.902, 0.522)
		else:
			cont_pop[i].color = Color(0.0, 0.0, 0.0, 0.522)

func pontos(c, w, p):
	var total = 2*c + 3*w + p
	return total

func clas():
	var pontos0 = pontos(GameManager.sauna_stats["confort"], GameManager.sauna_stats["water"], GameManager.sauna_stats["popularity"])
	var pontos1 = pontos(GameManager.sr1_stats["confort"], GameManager.sr1_stats["water"], GameManager.sr1_stats["popularity"])
	var pontos2 = pontos(GameManager.sr2_stats["confort"], GameManager.sr2_stats["water"], GameManager.sr2_stats["popularity"])
	var pontos3 = pontos(GameManager.sr3_stats["confort"], GameManager.sr3_stats["water"], GameManager.sr3_stats["popularity"])
	var pontuacao_final = [
		{"sauna": 0, "pontos": pontos0, "nome": nomes_sauna[0]},
		{"sauna": 1, "pontos": pontos1, "nome": nomes_sauna[1]},
		{"sauna": 2, "pontos": pontos2, "nome": nomes_sauna[2]},
		{"sauna": 3, "pontos": pontos3, "nome": nomes_sauna[3]}
		]
	pontuacao_final.sort_custom(func(a,b): return a["pontos"] > b["pontos"])
	for i in range (4):
		class_saunas[i].text = "%s - %s" %[pontuacao_final[i]["nome"], pontuacao_final[i]["pontos"]]
