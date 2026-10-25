extends Node3D

#I have made plenty of mistakes when writing these scripts.
#am I going to fix them? probably not.
#planning a game out for once instead of yoloing it?!!??! that's insane.
@export var nealAI : int = 0
@export var caneToadAI : int = 0
@export var kangarooMafiaAI : int = 0
@export var evilAssEagleAI : int = 0
@export var kangarooDestruction : int = 0
#import all the rooms into this script
@export var office : Node3D
@export var inside : Node3D
@export var outside : Node3D
@export var powerRoom : Node3D
@export var kangarooActive : bool = false
@onready var globals = get_node("/root/Global")
@onready var nightEnd : Timer = $nightEnd

#timers for moving
@onready var nealTime = $nealTimer
@onready var toadTime = $toadTimer
@onready var eagleTime = $eagleTimer
@onready var kangarooTime = $kangarooTimer
#death timers when they are in your office
@onready var nealDeath : Timer = $nealDeath
@onready var toadDeath : Timer = $toadDeath
@onready var eagleDeath : Timer = $eagleDeath
#except for these guys they work differently
@onready var kangarooDeath : Timer = $kangarooDeath
@onready var deathMessage : Label = $Control/Label

var nealProgress : int = 0
var toadProgress : int = 0
var eagleProgress : int = 0
var dead : bool = false
var toadActive : bool = false
var time : int = 12

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$nightEnd.start()
	match globals.currentNight:
		1:
			nealAI = 3
			nealTime.start()
		2:
			nealAI = 4
			caneToadAI = 2
			nealTime.start()
			toadTime.start()
		3:
			nealAI = 6
			caneToadAI = 5
			evilAssEagleAI = 3
			nealTime.start()
			toadTime.start()
			eagleTime.start()
		4:
			nealAI = 8
			caneToadAI = 7
			evilAssEagleAI = 2
			kangarooMafiaAI = 3
			nealTime.start()
			toadTime.start()
			eagleTime.start()
			kangarooTime.start()
		5:
			nealAI = 10
			caneToadAI = 9
			evilAssEagleAI = 4
			kangarooMafiaAI = 5
			nealTime.start()
			toadTime.start()
			eagleTime.start()
			kangarooTime.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (office.coneDeterantSystem and office.nealInOffice):
		nealDeath.stop()
		nealProgress = 0
		nealTime.start()
	if (office.caneToadInOffice):
		toadDeath.stop()
		toadProgress = 0
		toadTime.start()
	match nealProgress:
		0:
			outside.isNealCam4 = false
			outside.isNealCam3 = false
			inside.isNealCam2 = false
			office.nealInOffice = false
		1:
			outside.isNealCam4 = false
			outside.isNealCam3 = true
			inside.isNealCam2 = false
			office.nealInOffice = false
		2:
			outside.isNealCam4 = true
			outside.isNealCam3 = false
			inside.isNealCam2 = false
			office.nealInOffice = false
		3:
			outside.isNealCam4 = false
			outside.isNealCam3 = false
			inside.isNealCam2 = true
			office.nealInOffice = false
		4:
			outside.isNealCam4 = false
			outside.isNealCam3 = false
			inside.isNealCam2 = false
			office.nealInOffice = true



func _on_neal_timer_timeout() -> void:
	var moveNum : int = randi_range(1, 20)
	if (nealProgress == 4):
		nealTime.stop()
		nealDeath.start()
	elif (moveNum <= nealAI):
		nealProgress += 1
		#print("moved!")

func _on_toad_timer_timeout() -> void:
	var moveNum : int = randi_range(1, 20)
	if (toadProgress == 5):
		toadTime.stop()
		toadDeath.start()
		office.caneToadInOffice = true
		office.latch = true
		toadActive = true
	elif (moveNum <= caneToadAI):
		toadProgress += 1
		#print("moved")


func _on_eagle_timer_timeout() -> void:
	var moveNum : int = randi_range(1, 20)
	if (eagleProgress == 3):
		eagleTime.stop()
		eagleDeath.start()
		$eagleAlert.play()
	if (moveNum <= evilAssEagleAI):
		eagleProgress += 1

#these kangaroos might have the most amount of logic
func _on_kangaroo_timer_timeout() -> void:
	var moveNum : int = randi_range(1, 20)
	if (moveNum <= kangarooMafiaAI):
		var choosePath = randi_range(1, 10)
		if(!kangarooActive):
			if (choosePath <= 7):
				var chooseCam = randi_range(1, 4)
				kangarooActive = true
				kangarooDeath.start()
				$motionAlert.play()
				#so much...
				match chooseCam:
					1:
						inside.isKangarooCam1 = true
						inside.isKangarooCam2 = false
						outside.isKangarooCam3 = false
						outside.isKangarooCam4 = false
						print(1)
					2:
						inside.isKangarooCam1 = false
						inside.isKangarooCam2 = true
						outside.isKangarooCam3 = false
						outside.isKangarooCam4 = false
						print(2)
					3:
						inside.isKangarooCam1 = false
						inside.isKangarooCam2 = false
						outside.isKangarooCam3 = true
						outside.isKangarooCam4 = false
						print(3)
					4:
						inside.isKangarooCam1 = false
						inside.isKangarooCam2 = false
						outside.isKangarooCam3 = false
						outside.isKangarooCam4 = true
						print(4)
			elif (choosePath > 7):
				powerRoom.kangarooInRoom = true
				kangarooActive = true
				kangarooDeath.start()
				print(5)


func _on_neal_death_timeout() -> void:
	dead = true
	deathMessage.text = "You died."
	$Control.visible = true
	$youDed.start()

func _on_kangaroo_death_timeout() -> void:
	if (powerRoom.kangarooInRoom):
		office.isPowerOn = false
		powerRoom.kangarooInRoom = false
	else:
		kangarooDestruction += 1
		print("destroyed")
		kangarooActive = false
		inside.isKangarooCam1 = false
		inside.isKangarooCam2 = false
		outside.isKangarooCam3 = false
		outside.isKangarooCam4 = false
		if (kangarooDestruction == 2):
			deathMessage.text = "You died."
			$Control.visible = true
			$youDed.start()

func _on_toad_death_timeout() -> void:
	dead = true
	deathMessage.text = "You died."
	$Control.visible = true
	$youDed.start()

func _on_eagle_death_timeout() -> void:
	if (office.isDoorClosed):
		eagleTime.start()
		$eagleHit.play()
	else:
		dead = true
		deathMessage.text = "You died."
		$Control.visible = true
		$youDed.start()


func _on_night_end_timeout() -> void:
	if (time == 12):
		time = 0
	time += 1
	if (time >= 6):
		if (globals.currentNight == 5):
			pass
		else:
			globals.currentNight += 1
		deathMessage.text = "6 AM"
		$Control.visible = true
		$youDed.start()


func _on_you_ded_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
