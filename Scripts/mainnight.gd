class_name mainScene
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
@export var office : office
@export var inside : insideRoom
@export var outside : outside
@export var powerRoom : powerRoom
@export var kangarooActive : bool = false
@export var legs : legs


@onready var globals : global = get_node("/root/Global")
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
@onready var charMovedTimer : Timer = $charMove
@onready var legsTimer : Timer = $legsMovement

var nealProgress : int = 0
var toadProgress : int = 0
var eagleProgress : int = 0
var dead : bool = false
var time : int = 12
var hasCharacterMoved : bool = false
var whereKangaroo : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$nightEnd.start()
	legs.position = Vector3(-72.96, 0.128, -23.59)
	legs.rotate_y(deg_to_rad(180))
	legs.scale = Vector3(1, 1, 1)
	if (globals.isLegsNight):
		nealAI = 20
		caneToadAI = 20
		evilAssEagleAI = 20
		kangarooMafiaAI = 20
		legsTimer.start()
		nealTime.start()
		toadTime.start()
		eagleTime.start()
		kangarooTime.start()
	elif (globals.isCustomNight):
		nealAI = globals.nealAi
		caneToadAI = globals.toadAi
		evilAssEagleAI = globals.eagleAi
		kangarooMafiaAI = globals.kangarooAi
		nealTime.start()
		toadTime.start()
		eagleTime.start()
		kangarooTime.start()
	else:
		checkNight()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (office.coneDeterantSystem and office.nealInOffice):
		nealDeath.stop()
		nealProgress = 0
		nealTime.start()
	if (office.caneToadInOffice and office.buttonPressed):
		office.buttonPressed = false
		toadDeath.stop()
		toadProgress = 0
		toadTime.start()
	match nealProgress:
		0:
			outside.isNealCam1 = false
			outside.isNealCam2 = false
			inside.isNealCam3 = false
			office.nealInOffice = false
		1:
			outside.isNealCam1 = true
			outside.isNealCam2 = false
			inside.isNealCam3 = false
			office.nealInOffice = false
		2:
			outside.isNealCam1 = false
			outside.isNealCam2 = true
			inside.isNealCam3 = false
			office.nealInOffice = false
		3:
			outside.isNealCam1 = false
			outside.isNealCam2 = false
			inside.isNealCam3 = true
			office.nealInOffice = false
		4:
			outside.isNealCam1 = false
			outside.isNealCam2 = false
			inside.isNealCam3 = false
			office.nealInOffice = true
			
	if (hasCharacterMoved and office.isInCams):
		hasCharacterMoved = false
		match nealProgress:
			1:
				if (office.whichCam == 1):
					$"character moved".visible = true
					charMovedTimer.start()
			2:
				if (office.whichCam == 2 or office.whichCam == 1):
					$"character moved".visible = true
					charMovedTimer.start()
			3:
				if (office.whichCam == 3 or office.whichCam == 2):
					$"character moved".visible = true
					charMovedTimer.start()
			4:
				if (office.whichCam == 3):
					$"character moved".visible = true
					charMovedTimer.start()
		match whereKangaroo:
			1:
				if (office.whichCam == 1):
					$"character moved".visible = true
					charMovedTimer.start()
			2:
				if (office.whichCam == 2):
					$"character moved".visible = true
					charMovedTimer.start()
			3:
				if (office.whichCam == 3):
					$"character moved".visible = true
					charMovedTimer.start()
			4:
				if (office.whichCam == 4):
					$"character moved".visible = true
					charMovedTimer.start()
			5:
				if (office.whichCam == 5):
					$"character moved".visible = true
					charMovedTimer.start()
	
	if (charMovedTimer.is_stopped()):
		$"character moved".visible = false
	
	
	if (office.isInCams):
		match office.whichCam:
			1:
				if (legs.legsProgress == 0):
					legsTimer.paused = true
				else:
					legsTimer.paused = false
			2:
				if (legs.legsProgress == 1):
					legsTimer.paused = true
				else:
					legsTimer.paused = false
			3:
				if (legs.legsProgress == 2):
					legsTimer.paused = true
				else:
					legsTimer.paused = false
	else:
		legsTimer.paused = false


func checkNight():
	match globals.currentNight:
		1:
			nealAI = 5
			caneToadAI = 3
			nealTime.start()
			toadTime.start()
		2:
			nealAI = 6
			caneToadAI = 5
			evilAssEagleAI = 3
			nealTime.start()
			toadTime.start()
			eagleTime.start()
		3:
			nealAI = 8
			caneToadAI = 7
			evilAssEagleAI = 2
			kangarooMafiaAI = 3
			nealTime.start()
			toadTime.start()
			eagleTime.start()
			kangarooTime.start()
		4:
			nealAI = 9
			caneToadAI = 8
			evilAssEagleAI = 5
			kangarooMafiaAI = 4
			nealTime.start()
			toadTime.start()
			eagleTime.start()
			kangarooTime.start()
		5:
			nealAI = 10
			caneToadAI = 9
			evilAssEagleAI = 6
			kangarooMafiaAI = 5
			nealTime.start()
			toadTime.start()
			eagleTime.start()
			kangarooTime.start()


func _on_neal_timer_timeout() -> void:
	var moveNum : int = randi_range(1, 20)
	if (nealProgress == 4):
		nealTime.stop()
		nealDeath.start()
	elif (moveNum <= nealAI):
		nealProgress += 1
		hasCharacterMoved = true
		#print("moved!")


func _on_toad_timer_timeout() -> void:
	var moveNum : int = randi_range(1, 20)
	if (toadProgress == 5):
		toadTime.stop()
		toadDeath.start()
		office.caneToadInOffice = true
		office.latch = true
		$toadAlert.play()
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
			$motionAlert.play()
			hasCharacterMoved = true
			if (choosePath <= 7):
				var chooseCam = randi_range(1, 4)
				kangarooActive = true
				kangarooDeath.start()
				#so much...
				match chooseCam:
					1:
						outside.isKangarooCam1 = true
						outside.isKangarooCam2 = false
						inside.isKangarooCam3 = false
						inside.isKangarooCam4 = false
						whereKangaroo = 1
						print(1)
					2:
						outside.isKangarooCam1 = false
						outside.isKangarooCam2 = true
						inside.isKangarooCam3 = false
						inside.isKangarooCam4 = false
						whereKangaroo = 2
						print(2)
					3:
						outside.isKangarooCam1 = false
						outside.isKangarooCam2 = false
						inside.isKangarooCam3 = true
						inside.isKangarooCam4 = false
						whereKangaroo = 3
						print(3)
					4:
						outside.isKangarooCam1 = false
						outside.isKangarooCam2 = false
						inside.isKangarooCam3 = false
						inside.isKangarooCam4 = true
						whereKangaroo = 4
						print(4)
			elif (choosePath > 7):
				powerRoom.kangarooInRoom = true
				kangarooActive = true
				kangarooDeath.start()
				whereKangaroo = 5
				print(5)


func _on_neal_death_timeout() -> void:
	dead = true
	office.deathMessage.text = "You died."
	office.isDead = true
	office.latchTwo = true
	office.tip.text = "neal LOVES cones. Use the CDS when he's nearest!"
	office.deathPlayer.play("nealKill")
	$youDed.start()

func _on_kangaroo_death_timeout() -> void:
	if (powerRoom.kangarooInRoom):
		office.isPowerOn = false
		office.latchTwo = true
		powerRoom.kangarooInRoom = false
	else:
		kangarooDestruction += 1
		$kangarooDestruction.play()
		kangarooActive = false
		outside.isKangarooCam1 = false
		outside.isKangarooCam2 = false
		inside.isKangarooCam3 = false
		inside.isKangarooCam4 = false
		whereKangaroo = 0
		if (kangarooDestruction == 2):
			office.deathMessage.text = "FIRED"
			office.tip.text = "The kangaroos destroyed too much, use your alarm when you see them!"
			$youDed.start()

func _on_toad_death_timeout() -> void:
	dead = true
	office.deathMessage.text = "You died."
	office.tip.text = "Birds love easy prey. Use the bright red button on your desk to summon one!"
	office.isDead = true
	office.latchTwo = true
	office.deathPlayer.play("toadKill")
	$youDed.start()

func _on_eagle_death_timeout() -> void:
	if (office.isDoorClosed):
		eagleTime.start()
		$eagleHit.play()
		eagleProgress = 0
	else:
		dead = true
		office.deathMessage.text = "You died."
		office.tip.text = "When you hear it, Use the door to your right to block it!"
		office.isDead = true
		office.latchTwo = true
		office.deathPlayer.play("eagleKill")
		$youDed.start()


func _on_night_end_timeout() -> void:
	if (time == 12):
		time = 0
	time += 1
	if (time >= 6 and !globals.isCustomNight):
		if (globals.currentNight == 5):
			globals.nightFiveComplete = true
		else:
			globals.currentNight += 1
		office.deathMessage.text = "6 AM"
		globals.saveGame()
		$toTitle.start()
	if (nealAI == 20 and caneToadAI == 20 and evilAssEagleAI == 20 and kangarooMafiaAI == 20 and time >= 6):
		office.deathMessage.text = "6 AM"
		$Control.visible = true
		globals.fourTwenty = true
		globals.saveGame()
		$toTitle.start()
	if (globals.isLegsNight and time >= 6):
		office.deathMessage.text = "6 AM"
		$Control.visible = true
		globals.legsBeaten = true
		globals.saveGame()
		$toTitle.start()


func _on_you_ded_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")


func _on_legs_movement_timeout() -> void:
	legs.legsProgress += 1
	match legs.legsProgress:
		1:
			legs.position = Vector3(-78.20, 0, -11.42)
			legs.rotate_y(deg_to_rad(180))
		2:
			legs.position = Vector3(25.65, 0, -7.7)
			legs.rotate_y(deg_to_rad(90))
		3:
			legs.position = Vector3(-7.15, -0.042, 15.401)
			legs.scale = Vector3(0.6, 0.6, 0.6)
			legs.rotate_y(deg_to_rad(-30))
	if (legs.legsProgress == 4):
		legs.position = Vector3(-6.229, -0.507, 16.809)
		legs.rotate_y(deg_to_rad(-60))
		legs.aniPlayer.play("DEAD")
		if (legs.aniPlayer.is_playing()):
			await legs.aniPlayer.animation_finished
			get_tree().quit()


func _on_to_title_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
