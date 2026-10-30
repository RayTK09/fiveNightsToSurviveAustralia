class_name global
extends Node


@export var currentNight : int = 1
@export var nightFiveComplete : bool = false
@export var nightSixComplete : bool = false
@export var fourTwenty : bool = false

@export var isCustomNight : bool = false
@export var nealAi : int
@export var toadAi : int
@export var eagleAi : int
@export var kangarooAi : int


func _ready() -> void:
	loadData()

#Special thanks to the godot wiki for teaching me how to do this stuff
func saveGame():
	var saveFile := FileAccess.open("user://save.json", FileAccess.WRITE)
	
	var saveData := {
		"Night" = currentNight,
		"Night5completed" = nightFiveComplete,
		"Night6completed" = nightSixComplete,
		"modecompleted420" = fourTwenty
	}
	
	saveFile.store_line(JSON.stringify(saveData))
	
	
func loadData():
	var saveFile := FileAccess.open("user://save.json", FileAccess.READ)
	var json := JSON.new()
	json.parse(saveFile.get_line())
	var saveData := json.get_data() as Dictionary
	
	currentNight = saveData.Night
	nightFiveComplete = saveData.Night5completed
	nightSixComplete = saveData.Night6completed
	fourTwenty = saveData.modecompleted420
	
	
