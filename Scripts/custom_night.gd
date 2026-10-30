extends Control

@onready var globals : global = get_node("/root/Global")
@onready var nealLabelAi : Label = $VBoxContainer/neal/nealAI
@onready var toadLabelAi : Label = $VBoxContainer/toad/toadAI
@onready var eagleLabelAi : Label = $VBoxContainer/eagle/eagleAI
@onready var kangarooLabelAi : Label = $VBoxContainer/kangaroo/kangarooAI

var nealAi : int = 0
var toadAi : int = 0
var eagleAi : int = 0
var kangarooAi : int = 0

func _process(delta: float) -> void:
	globals.nealAi = nealAi
	globals.toadAi = toadAi
	globals.eagleAi = eagleAi
	globals.kangarooAi = kangarooAi


func _on_neal_decrease_pressed() -> void:
	nealAi -= 1
	if nealAi < 0:
		nealAi = 0
	nealLabelAi.text = str(nealAi)


func _on_neal_increase_pressed() -> void:
	nealAi += 1
	if nealAi > 20:
		nealAi = 20
	nealLabelAi.text = str(nealAi)


func _on_toad_decrease_pressed() -> void:
	toadAi -= 1
	if toadAi < 0:
		toadAi = 0
	toadLabelAi.text = str(toadAi)


func _on_toad_increase_pressed() -> void:
	toadAi += 1
	if toadAi > 20:
		toadAi = 20
	toadLabelAi.text = str(toadAi)


func _on_eagle_decrease_pressed() -> void:
	eagleAi -= 1
	if eagleAi < 0:
		eagleAi = 0
	eagleLabelAi.text = str(eagleAi)


func _on_eagle_increase_pressed() -> void:
	eagleAi += 1
	if eagleAi > 20:
		eagleAi = 20
	eagleLabelAi.text = str(eagleAi)


func _on_kangaroo_decrease_pressed() -> void:
	kangarooAi -= 1
	if kangarooAi < 0:
		kangarooAi = 0
	kangarooLabelAi.text = str(kangarooAi)


func _on_kangaroo_increase_pressed() -> void:
	kangarooAi += 1
	if kangarooAi > 20:
		kangarooAi = 20
	kangarooLabelAi.text = str(kangarooAi)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")


func _on_start_pressed() -> void:
	globals.isCustomNight = true
	$ColorRect2.visible = true
	$currentNight.text = "Night Six"
	$Timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainnight.tscn")
