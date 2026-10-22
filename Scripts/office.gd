extends Node3D

@onready var player = $Camera3D
@onready var aniPlayer = $AnimationPlayer

var nealInOffice : bool = false
var caneToadInOffice : bool = false
var isPowerOn : bool = true
var turnAmount : float = 0
var isInCams : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("OpenCams") and !isInCams):
		isInCams = true
		aniPlayer.play("flipCamera")
		player.current = false
	elif (Input.is_action_just_pressed("OpenCams") and isInCams):
		isInCams = false
		aniPlayer.play_backwards("flipCamera")
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
