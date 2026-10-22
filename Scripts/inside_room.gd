extends Node3D

@onready var cam1Light = $Camera3D/SpotLight3D
@onready var cam2Light = $Camera3D2/SpotLight3D

#Im gonna do a funny
@export var cam1Active : bool = false
@export var cam2Active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (cam1Active):
		cam1Light.spot_attenuation = 1
	else:
		cam1Light.spot_angle_attenuation = 10
	if (cam2Active):
		cam2Light.spot_attenuation = 1
	else:
		cam2Light.spot_angle_attenuation = 10
