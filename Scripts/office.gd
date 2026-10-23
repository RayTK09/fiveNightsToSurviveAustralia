extends Node3D

@onready var player = $Camera3D
@onready var aniPlayer = $AnimationPlayer

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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam1 = $Control/cam1
	cam2 = $Control/cam2
	cam3 = $Control/cam3
	cam4 = $Control/cam4
	cam5 = $Control/cam5

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("OpenCams") and !isInCams):
		isInCams = true
		aniPlayer.play("flipCamera")
	elif (Input.is_action_just_pressed("OpenCams") and isInCams):
		isInCams = false
		aniPlayer.play("flipCamDown")
		player.current = true

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

#no genAI was used in the making of this
#and on second thought I have no idea why I did this the way I did
func _on_cam_1_pressed() -> void:
	outside.cam4Active = true
	outside.cam3Active = false
	inside.cam2Active = false
	inside.cam1Active = false
	power.camActive = false


func _on_cam_2_pressed() -> void:
	outside.cam4Active = false
	outside.cam3Active = true
	inside.cam2Active = false
	inside.cam1Active = false
	power.camActive = false


func _on_cam_3_pressed() -> void:
	outside.cam4Active = false
	outside.cam3Active = false
	inside.cam2Active = true
	inside.cam1Active = false
	power.camActive = false


func _on_cam_4_pressed() -> void:
	outside.cam4Active = false
	outside.cam3Active = false
	inside.cam2Active = false
	inside.cam1Active = true
	power.camActive = false


func _on_cam_5_pressed() -> void:
	outside.cam4Active = false
	outside.cam3Active = false
	inside.cam2Active = false
	inside.cam1Active = false
	power.camActive = true
