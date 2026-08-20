extends TextureRect

@onready var btn_abrir_mapa = $btn_abrir_mapa
@onready var btn_fechar_mapa = $"../mapa/ColorRect2/btn_fechar_mapa"
@onready var mapa = $"../mapa"
@onready var info_item = $"../info_item"
@onready var info_icon = $"../info_item/caixa_info/icon_info"
@onready var info_desc = $"../info_item/caixa_info/label_info"
@onready var info_quant = $"../info_item/caixa_info/label_quant"
@onready var info_nome = $"../info_item/caixa_info/label_nome"
@onready var bg_livro = $"../bg_livro"
@onready var popup = $"../bg_livro/popup_confirm"

@onready var madeira_icon = $slot_madeira/btn_madeira
@onready var madeira_count = $slot_madeira/Label
@onready var carvao_icon = $slot_carvao/btn_carvao
@onready var carvao_count = $slot_carvao/Label
@onready var up_toalha_icon = $slot_up_toalha/btn_toalha
@onready var up_toalha_count = $slot_up_toalha/Label
@onready var up_eucalipto_icon = $slot_up_eucalipto/btn_eucalipto
@onready var up_eucalipto_count = $slot_up_eucalipto/Label
@onready var up_cerca_icon = $slot_up_cerca/btn_cerca
@onready var up_cerca_count = $slot_up_cerca/Label

func _ready() -> void:
	mapa.visible = false
	btn_fechar_mapa.disabled = true
	info_item.visible = false
	bg_livro.visible = false
	popup.visible = false
	GameManager.inventory_changed.connect(update_inventory)
	update_inventory()
	GameManager.map_changed.connect(update_btn_rune)
	update_btn_rune()
	GameManager.ja_dormiu.connect(update_timer)
	update_timer()

func ativar_btns():
	$ColorRect2/btn_puxar.disabled = false
	$runebook/btn_runebook.disabled = false
	$ColorRect3/btn_info_sauna.disabled = false
func desativar_btns():
	$ColorRect2/btn_puxar.disabled = true
	$runebook/btn_runebook.disabled = true
	$ColorRect3/btn_info_sauna.disabled = true

#====================================================================================================================================================
#PUXAR MENU
var tween: Tween
var original_y = -513
var aberto = false

func _on_btn_puxar_pressed() -> void:
	if aberto == true:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position:y", original_y, 0.3)
		aberto = false
	elif aberto == false:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position:y", original_y + 135, 0.3)
		aberto = true

#====================================================================================================================================================
#MAPA
func _on_btn_abrir_mapa_pressed() -> void:
	mapa.visible = true
	btn_fechar_mapa.disabled = false
	GameManager.player_mov = false
	desativar_btns()
func _on_btn_fechar_mapa_pressed() -> void:
	mapa.visible = false
	btn_fechar_mapa.disabled = true
	GameManager.player_mov = true
	ativar_btns()

#====================================================================================================================================================
#INDICADOR DIAS
func update_timer():
	if GameManager.is_daytime:
		$lbl_dias.text = "DIA %s" %[str(GameManager.current_day)]
	if not GameManager.is_daytime:
		$lbl_dias.text = "NOITE %s" %[str(GameManager.current_day)]

#====================================================================================================================================================
#ITENS
func update_inventory():
	var madeira = GameManager.inventory["madeira"]
	madeira_icon.visible = madeira > 0
	madeira_icon.disabled = madeira <= 0
	madeira_count.visible = madeira > 0
	madeira_count.text = str(madeira)
	var carvao = GameManager.inventory["carvao"]
	carvao_icon.visible = carvao > 0
	carvao_icon.disabled = carvao <= 0
	carvao_count.visible = carvao > 0
	carvao_count.text = str(carvao)
	var up_toalha = GameManager.inventory["up_toalha"]
	up_toalha_icon.visible = up_toalha > 0
	up_toalha_icon.disabled = up_toalha <= 0
	up_toalha_count.visible = up_toalha > 0
	up_toalha_count.text = str(up_toalha)
	var up_eucalipto = GameManager.inventory["up_eucalipto"]
	up_eucalipto_icon.visible = up_eucalipto > 0
	up_eucalipto_icon.disabled = up_eucalipto <= 0
	up_eucalipto_count.visible = up_eucalipto > 0
	up_eucalipto_count.text = str(up_eucalipto)
	var up_cerca = GameManager.inventory["up_cerca"]
	up_cerca_icon.visible = up_cerca > 0
	up_cerca_icon.disabled = up_cerca <= 0
	up_cerca_count.visible = up_cerca > 0
	up_cerca_count.text = str(up_cerca)

#====================================================================================================================================================
#INFO_ITENS
var desc_item = [
	"madeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeira",
	"carvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvao",
	"toalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalha",
	"eucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucalipto",
	"cercacercacercacercacercacercacercacercacercacercacercacercacercacercacercacercacercacercacercacercacercacerca"
]

func _on_btn_madeira_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["madeira"])
	info_desc.text = desc_item[0]
	info_nome.text = "Madeira"
	info_icon.texture = madeira_icon.texture_normal
	GameManager.player_mov = false
	desativar_btns()
func _on_btn_carvao_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["carvao"])
	info_desc.text = desc_item[1]
	info_nome.text = "Carvão"
	info_icon.texture = carvao_icon.texture_normal
	GameManager.player_mov = false
	desativar_btns()
func _on_btn_toalha_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["up_toalha"])
	info_desc.text = desc_item[2]
	info_nome.text = "Toalhas Fofinhas"
	info_icon.texture = up_toalha_icon.texture_normal
	GameManager.player_mov = false
	desativar_btns()
func _on_btn_eucalipto_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["up_eucalipto"])
	info_desc.text = desc_item[3]
	info_nome.text = "Essencia de Eucalipto"
	info_icon.texture = up_eucalipto_icon.texture_normal
	GameManager.player_mov = false
	desativar_btns()
func _on_btn_cerca_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["up_cerca"])
	info_desc.text = desc_item[4]
	info_nome.text = "Cercas novas"
	info_icon.texture = up_cerca_icon.texture_normal
	GameManager.player_mov = false
	desativar_btns()

func _on_btn_fechar_info_pressed() -> void:
	info_item.visible = false
	GameManager.player_mov = true
	ativar_btns()

#====================================================================================================================================================
#RUNEBOOK
var sauna_stats = [GameManager.sauna_stats, GameManager.sr1_stats, GameManager.sr2_stats, GameManager.sr3_stats]

func _on_btn_runebook_pressed() -> void:
	bg_livro.visible = true
	GameManager.player_mov = false
	desativar_btns()

func _on_btn_livro_pressed() -> void:
	bg_livro.visible = false
	GameManager.player_mov = true
	popup.visible = false
	$"../bg_livro/btn_runar".disabled = false
	$"../bg_livro/Node2D".get_node("btn_flip_back").disabled = false
	$"../bg_livro/Node2D".get_node("btn_flip_forward").disabled = false
	ativar_btns()

func update_btn_rune():
	if GameManager.allow_rune == true:
		$"../bg_livro/btn_runar".disabled = false
		$"../bg_livro/btn_mais_stats".disabled = false
	if GameManager.allow_rune == false:
		$"../bg_livro/btn_runar".disabled = true
		$"../bg_livro/btn_mais_stats".disabled = true

func _on_btn_runar_pressed() -> void:
	if GameManager.current_sauna != 0:
		var vitima = sauna_stats[GameManager.current_sauna]
		if vitima["confort"] > 0: vitima["confort"] -= 1 
		if vitima["water"] > 0: vitima["water"] -= 1
		if vitima["popularity"] > 0: vitima["popularity"] -= 1
	else:
		popup.visible = true
		popup.z_index = 1000
		$"../bg_livro/btn_runar".disabled = true
		$"../bg_livro/Node2D".get_node("btn_flip_back").disabled = true
		$"../bg_livro/Node2D".get_node("btn_flip_forward").disabled = true

func _on_btn_conf_pop_pressed() -> void:
	var vitima = sauna_stats[GameManager.current_sauna]
	if vitima["confort"] > 0: vitima["confort"] -= 1 
	if vitima["water"] > 0: vitima["water"] -= 1
	if vitima["popularity"] > 0: vitima["popularity"] -= 1
	popup.visible = false
	$"../bg_livro/btn_runar".disabled = false
	$"../bg_livro/Node2D".get_node("btn_flip_back").disabled = false
	$"../bg_livro/Node2D".get_node("btn_flip_forward").disabled = false

func _on_btn_neg_pop_pressed() -> void:
	popup.visible = false
	$"../bg_livro/btn_runar".disabled = false
	$"../bg_livro/Node2D".get_node("btn_flip_back").disabled = false
	$"../bg_livro/Node2D".get_node("btn_flip_forward").disabled = false

func _on_btn_mais_stats_pressed() -> void:
	var vitima = sauna_stats[GameManager.current_sauna]
	if vitima["confort"] < 4: vitima["confort"] += 1 
	if vitima["water"] < 3: vitima["water"] += 1
	if vitima["popularity"] < 5: vitima["popularity"] += 1

#====================================================================================================================================================
#DEBUG

func _on_b_1_pressed() -> void:
	GameManager.add_item("madeira")
func _on_b_11_pressed() -> void:
	GameManager.remove_item("madeira")

func _on_b_2_pressed() -> void:
	GameManager.add_item("carvao")
func _on_b_22_pressed() -> void:
	GameManager.remove_item("carvao")

func _on_b_3_pressed() -> void:
	GameManager.add_item("up_toalha")
func _on_b_33_pressed() -> void:
	GameManager.remove_item("up_toalha")

func _on_b_4_pressed() -> void:
	GameManager.add_item("up_eucalipto")
func _on_b_44_pressed() -> void:
	GameManager.remove_item("up_eucalipto")

func _on_b_5_pressed() -> void:
	GameManager.add_item("up_cerca")
func _on_b_55_pressed() -> void:
	GameManager.remove_item("up_cerca")
