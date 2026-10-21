extends Node3D

@onready var player = $Camera3D
@onready var turnLeftArea = $Camera3D/turnLeft
@onready var turnRightArea = $Camera3D/turnRight

var nealInOffice : bool = false
var caneToadInOffice : bool = false
var isPowerOn : bool = true

var turnAmount : float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_viewport().get_mouse_position().x <= get_viewport().get_visible_rect().size.x / 7 and Window.get_focused_window() == get_window():
		turnAmount = 1
	elif get_viewport().get_mouse_position().x >= get_viewport().get_visible_rect().size.x / 1.2 and Window.get_focused_window() == get_window():
		turnAmount = -1
	else:
		turnAmount = 0
		
	player.rotate_y(deg_to_rad(turnAmount))
	if player.rotation_degrees > Vector3(0, 30, 0):
		player.rotation_degrees = Vector3(0, 30, 0)
	elif player.rotation_degrees < Vector3(0, -30, 0):
		player.rotation_degrees = Vector3(0, -30, 0)
	
	print(turnAmount)
	print(player.rotation_degrees)
	#print(get_viewport().get_visible_rect().size.x / 1.2)
	#print(get_viewport().get_mouse_position())
