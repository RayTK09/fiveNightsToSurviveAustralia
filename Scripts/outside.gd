extends Node3D

@onready var cam3Light = $Camera3D/SpotLight3D
@onready var cam4Light = $Camera3D2/SpotLight3D

@export var cam3Active : bool = false
@export var cam4Active : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (cam3Active):
		cam3Light.spot_attenuation = 1
	else:
		cam3Light.spot_angle_attenuation = 10
	if (cam4Active):
		cam4Light.spot_attenuation = 1
	else:
		cam3Light.spot_angle_attenuation = 10
