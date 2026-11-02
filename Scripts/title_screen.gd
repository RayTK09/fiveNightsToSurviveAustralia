extends Node3D

@onready var globals : global = get_node("/root/Global")

func _ready() -> void:
	$Control/night.text = "Night " + str(globals.currentNight)
	if (globals.nightFiveComplete):
		$Night5Star.visible = true
	if (globals.fourTwenty):
		$Night6Star.visible = true
	if (globals.legsBeaten):
		$FISH.visible = true
	if (globals.nightFiveComplete):
		$Control/Button3.disabled = false
	

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("delete save data")):
		var saveFile = FileAccess.open("user://save.json", FileAccess.WRITE)
		saveFile.store_line(JSON.stringify({}))
		$Control/del.offset_transform_position = Vector2(435, 0)
		$Control/del.text = "Save file deleted!"

func _on_button_pressed() -> void:
	$Control/Button.visible = false
	$Control/Button2.visible = false
	$Control/Label.visible = false
	$Control/ColorRect.visible = true
	$Control/currentNight.visible = true
	$Control/currentNight.text = "Night " +  str(globals.currentNight)
	$Control/tip.visible = true
	$nightStart.play()
	$mainmenu.stop()
	$Control/del.text = ""
	match globals.currentNight:
		1:
			$Control/tip.text = "Tip: Neal loves cones!"
		2:
			$Control/tip.text = "Tip: The toads will consume all."
		3:
			$Control/tip.text = "Tip: EAGLE"
		4:
			$Control/tip.text = "Tip: Working with the kangaroo mafia isn't a good idea."
		5:
			$Control/tip.text = "Tip: They're all here."
	$Control/Timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainnight.tscn")


func _on_button_2_pressed() -> void:
	globals.saveGame()
	get_tree().quit()


func _on_button_mouse_entered() -> void:
	$Control/night.visible = true


func _on_button_mouse_exited() -> void:
	$Control/night.visible = false


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/custom_night.tscn")
