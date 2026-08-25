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

var cont_conf = []
var cont_agua = []
var cont_pop = []

var nomes_sauna = ["A velha sauna","A Fonte Cristalina","O Refúgio Aconchegante","A Sauna da Moda"]
var desc_saunas = [
	"   Já teve dias melhores. As tábuas rangem, a água não é das melhores e poucas pessoas ainda se lembram de quando este lugar era motivo de orgulho para a família. Agora, abandonada e quase esquecida, a velha sauna está longe de sua antiga glória.
	   Mas ela foi deixada para você como herança, e você não pretende deixá-la desaparecer. Com trabalho, dedicação e algumas boas ideias, talvez seja possível devolver à sauna o brilho de seus dias de ouro.",
	"   Conhecida por ter a água mais pura de toda a região. Cada gota é cuidadosamente tratada e dizem que até os clientes mais exigentes saem de lá sentindo que renasceram. Se existe uma sauna onde a água é levada a sério, é esta. ",
	"   Aqui, o objetivo é simples: fazer ninguém querer ir embora. Bancos macios, toalhas fofinhas, temperatura perfeita e um ambiente tão aconchegante que alguns clientes parecem esquecer que vieram para uma sauna e não para tirar uma soneca. ",
	"   A sauna mais comentada da cidade (e provavelmente a mais cheia também). Todo mundo quer dizer que já passou por aqui. Com fama, clientes fiéis e filas na porta, sua maior especialidade não é apenas proporcionar uma boa sauna… é fazer questão de que todo mundo saiba disso. "]


func open_info_sauna(num, c, w, p):
	nome_sauna.text = nomes_sauna[num]
	desc_sauna.text = desc_saunas[num]
	info_sauna.visible = true
	$"../bg_livro/btn_livro".disabled = true
	$"../bg_livro/btn_runar".disabled = true
	$"../TextureRect/ColorRect2/btn_puxar".disabled = true
	$"../TextureRect/ColorRect3/btn_info_sauna".disabled = true
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
	open_info_sauna(0, GameManager.sauna_stats["confort"], GameManager.sauna_stats["water"], GameManager.sauna_stats["popularity"])
func _on_btn_info_sauna_2_pressed() -> void:
	open_info_sauna(1, GameManager.sr1_stats["confort"], GameManager.sr1_stats["water"], GameManager.sr1_stats["popularity"])
func _on_btn_info_sauna_3_pressed() -> void:
	open_info_sauna(2, GameManager.sr2_stats["confort"], GameManager.sr2_stats["water"], GameManager.sr2_stats["popularity"])
func _on_btn_info_sauna_4_pressed() -> void:
	open_info_sauna(3, GameManager.sr3_stats["confort"], GameManager.sr3_stats["water"], GameManager.sr3_stats["popularity"])

func _on_btn_fechar_sauna_pressed() -> void:
	info_sauna.visible = false
	$"../bg_livro/btn_livro".disabled = false
	$"../bg_livro/btn_runar".disabled = false
	$"../TextureRect/ColorRect2/btn_puxar".disabled = false
	$"../TextureRect/ColorRect3/btn_info_sauna".disabled = false
	GameManager.player_mov = true
