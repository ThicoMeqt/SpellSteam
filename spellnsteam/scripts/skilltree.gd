extends Control

@onready var info = $info
@onready var popup = $info/popup
@onready var popuptext = $info/popup/popup/TextureRect/Label
@onready var info_nome = $info/Label
@onready var info_desc = $info/Label2
@onready var info_preco = $info/Label3
var text_fail = "Recursos Insuficientes."
var text_success = "Upgrade comprado com sucesso!"
var upA_nomes = ["Água Renovada", "Água Aquecida", "Banho de Eucalipto"]
var upA_desc = [
	"Uma pequena reforma para dar vida nova ao sistema de água da sauna. Com madeira nova e um pouco de trabalho, a água já começa a ficar mais limpa e agradável.", 
	"Um sistema de aquecimento mais eficiente transforma a sauna em um lugar muito mais confortável. A água agora pode atingir a temperatura ideal e permanecer quente por mais tempo.", 
	"Uma melhoria de respeito. Além de manter a água quente, a essência de eucalipto deixa um aroma refrescante e revigorante no ambiente. Agora a sauna começa a ter aquele toque especial que os clientes não esquecem."]
var upA_preco = ["3X madeira", "3X carvão", "3X cravão, 1X eucalipto"]
var upC_nomes = ["Bancos Novos", "Área Cercada", "Conforto Extra", "Sauna Renovada"]
var upC_desc = [
	"Bancos novos para substituir a madeira velha e desconfortável. Um pequeno investimento que já faz a sauna parecer muito mais acolhedora.", 
	"Uma cerca de madeira para delimitar e organizar melhor o espaço. Além de deixar tudo mais bonito, dá à sauna aquela sensação de um lugar bem cuidado.", 
	"Toalhas macias e um ambiente mais quentinho transformam uma simples visita à sauna em uma experiência muito mais confortável. Afinal, ninguém gosta de sair tremendo de frio.", 
	"Uma reforma completa no espaço, com madeira nova e cercas reforçadas. A velha sauna começa, finalmente, a recuperar o charme e o conforto que um dia fizeram parte de sua história."]
var upC_preco = ["3X madeira", "3X madeira, 1X cercas", "3X cravão, 1X toalhas", "4X madeira, 1X cercas"]
var upgrade = ""

func _ready():
	$VBoxContainer/HBoxContainer/water1.pressed.connect(_on_water1_pressed)
	$VBoxContainer/HBoxContainer/water2.pressed.connect(_on_water2_pressed)
	$VBoxContainer/HBoxContainer/water3.pressed.connect(_on_water3_pressed)
	$VBoxContainer2/HBoxContainer/comfort1.pressed.connect(_on_comfort1_pressed)
	$VBoxContainer2/HBoxContainer/comfort2.pressed.connect(_on_comfort2_pressed)
	$VBoxContainer2/HBoxContainer/comfort3.pressed.connect(_on_comfort3_pressed)
	$VBoxContainer2/HBoxContainer/comfort4.pressed.connect(_on_comfort4_pressed)
	setup_buttons()
	info.visible = false
	popup.visible = false

func setup_buttons():
	$VBoxContainer/HBoxContainer/water1.disabled = false
	$VBoxContainer2/HBoxContainer/comfort1.disabled = false
	$VBoxContainer/HBoxContainer/water2.disabled = true
	$VBoxContainer/HBoxContainer/water3.disabled = true
	$VBoxContainer2/HBoxContainer/comfort2.disabled = true
	$VBoxContainer2/HBoxContainer/comfort3.disabled = true
	$VBoxContainer2/HBoxContainer/comfort4.disabled = true

func info_upA(x):
	info.visible = true
	info_nome.text = upA_nomes[x]
	info_desc.text = upA_desc[x]
	info_preco.text = upA_preco[x]

func info_upC(x):
	info.visible = true
	info_nome.text = upC_nomes[x]
	info_desc.text = upC_desc[x]
	info_preco.text = upC_preco[x]

func _on_btn_conf_pressed() -> void:
	if upgrade == "w1":
		buy_w1()
	if upgrade == "w2":
		buy_w2()
	if upgrade == "w3":
		buy_w3()
	if upgrade == "c1":
		buy_c1()
	if upgrade == "c2":
		buy_c2()
	if upgrade == "c3":
		buy_c3()
	if upgrade == "c4":
		buy_c4()

func _on_btn_negar_pressed() -> void:
	info.visible = false

func _on_button_pressed() -> void:
	popup.visible = false
	if popuptext.text == str(text_success):
		info.visible = false

func fail():
	popup.visible = true
	popuptext.text = str(text_fail)
func success():
	popup.visible = true
	popuptext.text = str(text_success)
	
# ====================================================================================
# WATER UPGRADES
func _on_water1_pressed():
	upgrade = "w1"
	info_upA(0)
func buy_w1():
	if GameManager.inventory["madeira"] < 2 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["madeira"] -= 3
	GameManager.sauna_stats["water"] = 1
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	$VBoxContainer/HBoxContainer/water2.disabled = false
	$VBoxContainer/HBoxContainer/water1.disabled = true
	success()

func _on_water2_pressed():
	upgrade = "w2"
	info_upA(1)
func buy_w2():
	if GameManager.inventory["carvao"] < 2 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["carvao"] -= 3
	GameManager.sauna_stats["water"] = 2
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	$VBoxContainer/HBoxContainer/water3.disabled = false
	$VBoxContainer/HBoxContainer/water2.disabled = true
	success()

func _on_water3_pressed():
	upgrade = "w3"
	info_upA(2)
func buy_w3():
	if GameManager.inventory["carvao"] < 2 or GameManager.inventory["up_eucalipto"] < 1 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["carvao"] -= 3
	GameManager.inventory["up_eucalipto"] -= 1
	GameManager.sauna_stats["water"] = 3
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	$VBoxContainer/HBoxContainer/water3.disabled = true
	success()

# ====================================================================================
# COMFORT UPGRADES
func _on_comfort1_pressed():
	upgrade = "c1"
	info_upC(0)
func buy_c1():
	if GameManager.inventory["madeira"] < 2 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["madeira"] -= 3
	GameManager.sauna_stats["confort"] = 1
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	$VBoxContainer2/HBoxContainer/comfort2.disabled = false
	$VBoxContainer2/HBoxContainer/comfort1.disabled = true
	success()

func _on_comfort2_pressed():
	upgrade = "c2"
	info_upC(1)
func buy_c2():
	if GameManager.inventory["madeira"] < 2 or GameManager.inventory["up_cerca"] < 1 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["madeira"] -= 3
	GameManager.inventory["up_cerca"] -= 1
	GameManager.sauna_stats["confort"] = 2
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	$VBoxContainer2/HBoxContainer/comfort3.disabled = false
	$VBoxContainer2/HBoxContainer/comfort2.disabled = true
	success()

func _on_comfort3_pressed():
	upgrade = "c3"
	info_upC(2)
func buy_c3():
	if GameManager.inventory["carvao"] < 2 or GameManager.inventory["up_toalha"] < 1 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["carvao"] -= 3
	GameManager.inventory["up_toalha"] -= 1
	GameManager.sauna_stats["confort"] = 3
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	$VBoxContainer2/HBoxContainer/comfort4.disabled = false
	$VBoxContainer2/HBoxContainer/comfort3.disabled = true
	success()

func _on_comfort4_pressed():
	upgrade = "c4"
	info_upC(3)
func buy_c4():
	if GameManager.inventory["madeira"] < 4 or GameManager.inventory["up_cerca"] < 1 or GameManager.remaining_actions == 0:
		fail()
		return
	GameManager.inventory["madeira"] -= 4
	GameManager.inventory["up_cerca"] -= 1
	GameManager.sauna_stats["confort"] = 4
	GameManager.gastar_fogo(1)
	GameManager.inventory_changed.emit()
	$VBoxContainer2/HBoxContainer/comfort4.disabled = true
	success()
