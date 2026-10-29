extends Node3D

@onready var globals = get_node("/root/Global")

func _ready() -> void:
	$Control/night.text = "Night " + str(globals.currentNight)


func _on_button_pressed() -> void:
	$Control/Button.visible = false
	$Control/Button2.visible = false
	$Control/Label.visible = false
	$Control/ColorRect.visible = true
	$Control/currentNight.visible = true
	$Control/currentNight.text = "Night " +  str(globals.currentNight)
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
