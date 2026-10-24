extends Node3D

@onready var player = $Camera3D
@onready var aniPlayer = $AnimationPlayer
@onready var camUi = $Control/CamUI
@onready var alarmButton = $Control/CamUI/Alarm

@export var cam1 : TextureButton
@export var cam2 : TextureButton
@export var cam3 : TextureButton
@export var cam4 : TextureButton
@export var cam5 : TextureButton
@export var outside : Node3D
@export var inside : Node3D
@export var power : Node3D

var nealInOffice : bool = false
var caneToadInOffice : bool = false
var isPowerOn : bool = true
var turnAmount : float = 0
var isInCams : bool = false
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

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("OpenCams") and !isInCams):
		isInCams = true
		aniPlayer.play("flipCamera")
	elif (Input.is_action_just_pressed("OpenCams") and isInCams):
		isInCams = false
		aniPlayer.play("flipCamDown")
		player.current = true
		camUi.visible = false
		outside.cam4Active = false
		outside.cam3Active = false
		inside.cam2Active = false
		inside.cam1Active = false
		power.camActive = false

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
	
	
	#print(turnAmount)
	#print(player.rotation_degrees)
	#print(isInCams)
	#print(get_viewport().get_visible_rect().size.x / 1.2)
	#print(get_viewport().get_mouse_position())


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "flipCamera"):
		player.current = false
		camUi.visible = true
		outside.cam4Active = true


#on second thought I have no idea why I did this the way I did
func _on_cam_1_pressed() -> void:
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


func _on_cam_2_pressed() -> void:
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


func _on_cam_3_pressed() -> void:
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


func _on_cam_4_pressed() -> void:
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


func _on_cam_5_pressed() -> void:
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


func _on_alarm_button_down() -> void:
	if (outside.cam3Active or outside.cam4Active):
		outside.alarmActiveOutside = true


func _on_alarm_button_up() -> void:
	outside.alarmActiveOutside = false
