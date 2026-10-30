class_name office
extends Node3D

@onready var player : Camera3D = $Camera3D
@onready var aniPlayer : AnimationPlayer = $AnimationPlayer
@onready var camUi = $Control/CamUI
@onready var alarmButton = $Control/CamUI/Alarm
@onready var coneTimer = $coneTimer
@onready var audio = $AudioStreamPlayer

@export var cam1 : TextureButton
@export var cam2 : TextureButton
@export var cam3 : TextureButton
@export var cam4 : TextureButton
@export var cam5 : TextureButton
@export var outside : Node3D
@export var inside : Node3D
@export var power : Node3D
@export var main : Node3D
@export var coneDeterantSystem : bool = false
@export var nealInOffice : bool = false
@export var caneToadInOffice : bool = false

var isPowerOn : bool = true
var turnAmount : float = 0
var isInCams : bool = false
#theres so many variables
var cam1Normal
var cam2Normal
var cam3Normal
var cam4Normal
var cam5Normal
var cam1Active
var cam2Active
var cam3Active
var cam4Active
var cam5Active
var cone
var coneActive
var doorCanClose : bool = false
var isDoorClosed : bool = false
var latch : bool = false
var canPressButton : bool = false
#which was the last used camera?
var whichCam : int = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam1 = $Control/CamUI/cam1
	cam2 = $Control/CamUI/cam2
	cam3 = $Control/CamUI/cam3
	cam4 = $Control/CamUI/cam4
	cam5 = $Control/CamUI/cam5
	cam1Normal = load("res://sprites/camera1.png")
	cam2Normal = load("res://sprites/camera2.png")
	cam3Normal = load("res://sprites/camera3.png")
	cam4Normal = load("res://sprites/camera4.png")
	cam5Normal = load("res://sprites/camera5.png")
	cam1Active = load("res://sprites/cam1Selected.png")
	cam2Active = load("res://sprites/cam2Selected.png")
	cam3Active = load("res://sprites/cam3Selected.png")
	cam4Active = load("res://sprites/cam4Selected.png")
	cam5Active = load("res://sprites/cam5Selected.png")
	#Omg I hate my naming schemes
	cone = load("res://sprites/cone.png")
	coneActive = load("res://sprites/coneActive.png")

func _input(event: InputEvent) -> void:
	#omg I fixed the bug
	if (Input.is_action_just_pressed("OpenCams") and !isInCams and isPowerOn and !aniPlayer.is_playing()):
		isInCams = true
		aniPlayer.play("flipCamera")
		$camFlipUp.play()
	elif (Input.is_action_just_pressed("OpenCams") and isInCams and !aniPlayer.is_playing()):
		isInCams = false
		aniPlayer.play("flipCamDown")
		$camFlipDown.play()
		player.current = true
		camUi.visible = false
		outside.cam4Active = false
		outside.cam3Active = false
		inside.cam2Active = false
		inside.cam1Active = false
		power.camActive = false
	#flashlight
	if (Input.is_action_pressed("flashlightOn")):
		$flashlight.visible = true
	else:
		$flashlight.visible = false
	#door window closing
	if (Input.is_action_pressed("mouse") and doorCanClose and !isDoorClosed):
		$door2.play("door close")
		isDoorClosed = true
	elif (Input.is_action_just_released("mouse") and doorCanClose):
		$door2.play_backwards("door close")
		isDoorClosed = false
	
	if (Input.is_action_pressed('mouse') and caneToadInOffice):
		#print("grabbed")
		caneToadInOffice = false
		$toadPlayer.play("toadGrabbed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!isInCams):
		if (get_viewport().get_mouse_position().x <= get_viewport().get_visible_rect().size.x / 7 and Window.get_focused_window() == get_window()):
			turnAmount = 1
		elif (get_viewport().get_mouse_position().x >= get_viewport().get_visible_rect().size.x / 1.2 and Window.get_focused_window() == get_window()):
			turnAmount = -1
		else:
			turnAmount = 0
		
		player.rotate_y(deg_to_rad(turnAmount))
		if (player.rotation_degrees > Vector3(0, 30, 0)):
			player.rotation_degrees = Vector3(0, 30, 0)
		elif (player.rotation_degrees < Vector3(0, -30, 0)):
			player.rotation_degrees = Vector3(0, -30, 0)

	if (nealInOffice):
		$enemyPlayer.play("nealEnter")
	else:
		$enemyPlayer.stop()
		$neal.position = Vector3(-1.306, 0.203, 0.613)
		$AudioStreamPlayer2.stop()
	
	if ($Control/CamUI/cone.disabled):
		coneDeterantSystem = false
	
	if (caneToadInOffice and latch):
		latch = false
		$toadPlayer.play("toadDrop")
		
	$Control/CamUI/Label.text = str(main.time) + " AM"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "flipCamera"):
		player.current = false
		camUi.visible = true
		changeCam()

#A better way of handling camera switching
func changeCam() -> void:
	match whichCam:
			1:
				outside.cam4Active = true
				outside.cam3Active = false
				inside.cam2Active = false
				inside.cam1Active = false
				power.camActive = false
				cam1.texture_normal = cam1Active
				cam2.texture_normal = cam2Normal
				cam3.texture_normal = cam3Normal
				cam4.texture_normal = cam4Normal
				cam5.texture_normal = cam5Normal
			2:
				outside.cam4Active = false
				outside.cam3Active = true
				inside.cam2Active = false
				inside.cam1Active = false
				power.camActive = false
				cam1.texture_normal = cam1Normal
				cam2.texture_normal = cam2Active
				cam3.texture_normal = cam3Normal
				cam4.texture_normal = cam4Normal
				cam5.texture_normal = cam5Normal
			3:
				outside.cam4Active = false
				outside.cam3Active = false
				inside.cam2Active = false
				inside.cam1Active = true
				power.camActive = false
				cam1.texture_normal = cam1Normal
				cam2.texture_normal = cam2Normal
				cam3.texture_normal = cam3Active
				cam4.texture_normal = cam4Normal
				cam5.texture_normal = cam5Normal
			4:
				outside.cam4Active = false
				outside.cam3Active = false
				inside.cam2Active = true
				inside.cam1Active = false
				power.camActive = false
				cam1.texture_normal = cam1Normal
				cam2.texture_normal = cam2Normal
				cam3.texture_normal = cam3Normal
				cam4.texture_normal = cam4Active
				cam5.texture_normal = cam5Normal
			5:
				outside.cam4Active = false
				outside.cam3Active = false
				inside.cam2Active = false
				inside.cam1Active = false
				power.camActive = true
				cam1.texture_normal = cam1Normal
				cam2.texture_normal = cam2Normal
				cam3.texture_normal = cam3Normal
				cam4.texture_normal = cam4Normal
				cam5.texture_normal = cam5Active


#on second thought I have no idea why I did this the way I did
func _on_cam_1_pressed() -> void:
	whichCam = 1
	changeCam()
	audio.play()


func _on_cam_2_pressed() -> void:
	whichCam = 2
	changeCam()
	audio.play()


func _on_cam_3_pressed() -> void:
	whichCam = 3
	changeCam()
	audio.play()


func _on_cam_4_pressed() -> void:
	whichCam = 4
	changeCam()
	audio.play()


func _on_cam_5_pressed() -> void:
	whichCam = 5
	changeCam()
	audio.play()


func _on_alarm_button_down() -> void:
	if (outside.cam3Active or outside.cam4Active):
		outside.alarmActiveOutside = true
		outside.startTimer = true
	if (inside.cam2Active or inside.cam1Active):
		inside.alarmActiveInside = true
		inside.startTimer = true
	if (power.camActive):
		power.warningOn = true
		power.startTimer = true


func _on_alarm_button_up() -> void:
	outside.alarmActiveOutside = false
	inside.alarmActiveInside = false
	power.warningOn = false

func _on_cone_button_down() -> void:
	coneTimer.start()
	$Control/CamUI/cone.disabled = true
	coneDeterantSystem = true

func _on_cone_timer_timeout() -> void:
	$Control/CamUI/cone.disabled = false

func _on_button_mouse_entered() -> void:
	canPressButton = true

func _on_button_mouse_exited() -> void:
	canPressButton = false
	
func _on_door_mouse_entered() -> void:
	doorCanClose = true

func _on_door_mouse_exited() -> void:
	doorCanClose = false
	if (isDoorClosed):
		isDoorClosed = false
		$door2.play_backwards("door close")
