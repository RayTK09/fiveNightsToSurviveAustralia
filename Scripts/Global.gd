class_name global
extends Node


@export var currentNight : int = 1
@export var nightFiveComplete : bool = false
@export var fourTwenty : bool = false
@export var legsBeaten : bool = false

@export var isCustomNight : bool = false
@export var nealAi : int
@export var toadAi : int
@export var eagleAi : int
@export var kangarooAi : int
@export var isLegsNight : bool = false

var isFullscreened = false

func _ready() -> void:
	loadData()

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("fullscreen") and !isFullscreened):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif (Input.is_action_just_pressed("fullscreen") and isFullscreened):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#Special thanks to the godot wiki for teaching me how to do this stuff
func saveGame():
	var saveFile := FileAccess.open("user://save.json", FileAccess.WRITE)
	
	var saveData := {
		"Night" = currentNight,
		"Night5completed" = nightFiveComplete,
		"legsBeaten" = legsBeaten,
		"modecompleted420" = fourTwenty
	}
	
	saveFile.store_line(JSON.stringify(saveData))
	
	
func loadData():
	var saveFile := FileAccess.open("user://save.json", FileAccess.READ)
	var json := JSON.new()
	json.parse(saveFile.get_line())
	if (json.get_data() == {}):
		return
	var saveData := json.get_data() as Dictionary
	
	currentNight = saveData.Night
	nightFiveComplete = saveData.Night5completed
	legsBeaten = saveData.legsBeaten
	fourTwenty = saveData.modecompleted420
	
	
