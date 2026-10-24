extends Node3D

@onready var cam3Light = $Camera3D/SpotLight3D
@onready var cam4Light = $Camera3D2/SpotLight3D
@onready var alarmLight1 = $SpotLight3D
@onready var alarmLight2 = $SpotLight3D2
@onready var alarmLight3 = $SpotLight3D3

@export var cam3Active : bool = false
@export var cam4Active : bool = false

@export var isNealCam3 : bool = false
@export var isNealCam4 : bool = false
@export var isKangarooCam3 : bool = false
@export var isKangarooCam4 : bool = false
@export var alarmActiveOutside : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	alarmLight1.spot_attenuation = 3
	alarmLight2.spot_attenuation = 3
	alarmLight3.spot_attenuation = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (cam3Active):
		cam4Light.spot_attenuation = 1
		$Camera3D2.current = true
	else:
		cam4Light.spot_attenuation = 10
		$Camera3D2.current = false
	if (cam4Active):
		cam3Light.spot_attenuation = 1
		$Camera3D.current = true
	else:
		cam3Light.spot_attenuation = 10
		$Camera3D.current = false
		
	if (alarmActiveOutside):
		$AnimationPlayer.play("blinkingLights")
	elif (!alarmActiveOutside):
		$AnimationPlayer.stop()
	print(alarmActiveOutside)
