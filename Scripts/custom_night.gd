extends Control

@onready var globals : global = get_node("/root/Global")
@onready var nealLabelAi : Label = $VBoxContainer3/nealAI
@onready var toadLabelAi : Label = $VBoxContainer3/toadAI
@onready var eagleLabelAi : Label = $VBoxContainer3/eagleAI
@onready var kangarooLabelAi : Label = $VBoxContainer3/kangarooAI

var nealAi : int = 0
var toadAi : int = 0
var eagleAi : int = 0
var kangarooAi : int = 0

func _process(delta: float) -> void:
	globals.nealAi = nealAi
	globals.toadAi = toadAi
	globals.eagleAi = eagleAi
	globals.kangarooAi = kangarooAi
	
	if (int(nealLabelAi.text) >= 10):
		nealLabelAi.offset_transform_position = Vector2(-34, 0)
	else:
		nealLabelAi.offset_transform_position = Vector2(0, 0)
	if (int(toadLabelAi.text) >= 10):
		toadLabelAi.offset_transform_position = Vector2(-34, 0)
	else:
		toadLabelAi.offset_transform_position = Vector2(0, 0)
	if (int(eagleLabelAi.text) >= 10):
		eagleLabelAi.offset_transform_position = Vector2(-34, 0)
	else:
		eagleLabelAi.offset_transform_position = Vector2(0, 0)
	if (int(kangarooLabelAi.text) >= 10):
		kangarooLabelAi.offset_transform_position = Vector2(-34, 0)
	else:
		kangarooLabelAi.offset_transform_position = Vector2(0, 0)


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
	$ColorRect2/currentNight.text = "Night Six"
	$nightStart.play()
	$mainmenu.stop()
	$Timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainnight.tscn")
