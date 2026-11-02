class_name outside
extends Node3D

@onready var cam1Light = $Camera3D/SpotLight3D
@onready var cam2Light = $Camera3D2/SpotLight3D
@onready var alarmLight1 = $SpotLight3D
@onready var alarmLight2 = $SpotLight3D2
@onready var alarmLight3 = $SpotLight3D3
@onready var legsContainer := $LEGS
@onready var normalContainer := $hideOld
@onready var globals : global = get_node("/root/Global")

@export var cam1Active : bool = false
@export var cam2Active : bool = false
@export var isNealCam1 : bool = false
@export var isNealCam2 : bool = false
@export var isKangarooCam1 : bool = false
@export var isKangarooCam2 : bool = false
@export var alarmActiveOutside : bool = false
@export var main : mainScene

var startTimer : bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (cam1Active):
		cam1Light.light_energy = 1
		$Camera3D.current = true
	else:
		cam1Light.light_energy = 0
		$Camera3D.current = false
	if (cam2Active):
		cam2Light.light_energy = 1
		$Camera3D2.current = true
	else:
		cam2Light.light_energy = 0
		$Camera3D2.current = false
		
	if (alarmActiveOutside):
		$AnimationPlayer.play("blinkingLights")
	elif (!alarmActiveOutside):
		$AnimationPlayer.play("RESET")
	#print(alarmActiveOutside)
	if (isNealCam1):
		$nealCam2.visible = false
		$nealCam1.visible = true
	elif (isNealCam2):
		$nealCam2.visible = true
		$nealCam1.visible = false
	else:
		$nealCam2.visible = false
		$nealCam1.visible = false
	#kangaroos
	if (isKangarooCam1):
		$kangarooCam1.visible = true
	elif (isKangarooCam2):
		$kangarooCam2.visible = true
	
	if (alarmActiveOutside):
		if startTimer:
			startTimer = false
			$Timer.start()
		main.kangarooDeath.paused = true
	if (!alarmActiveOutside):
		$Timer.stop()
		$AudioStreamPlayer.stop()
		main.kangarooDeath.paused = false
	
	#check for whether the night is secret and change the container to the right one
	if (globals.isLegsNight):
		legsContainer.visible = true
		normalContainer.visible = false

func _on_timer_timeout() -> void:
	if (isKangarooCam1 and cam1Active):
		#print("deactivated")
		isKangarooCam1 = false
		main.kangarooActive = false
		main.hasCharacterMoved = true
		$kangarooCam1.visible = false
		main.kangarooDeath.stop()
	elif (isKangarooCam2 and cam2Active):
		#print("deactivated")
		isKangarooCam2 = false
		main.kangarooActive = false
		main.hasCharacterMoved = true
		$kangarooCam2.visible = false
		main.kangarooDeath.stop()
