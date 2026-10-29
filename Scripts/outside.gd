class_name outside
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
@export var main : Node3D

var startTimer : bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (cam3Active):
		cam4Light.light_energy = 1
		$Camera3D2.current = true
	else:
		cam4Light.light_energy = 0
		$Camera3D2.current = false
	if (cam4Active):
		cam3Light.light_energy = 1
		$Camera3D.current = true
	else:
		cam3Light.light_energy = 0
		$Camera3D.current = false
		
	if (alarmActiveOutside):
		$AnimationPlayer.play("blinkingLights")
	elif (!alarmActiveOutside):
		$AnimationPlayer.play("RESET")
	#print(alarmActiveOutside)
	if (isNealCam4):
		$nealCam4.visible = true
		$nealCam3.visible = false
	elif (isNealCam3):
		$nealCam4.visible = false
		$nealCam3.visible = true
	else:
		$nealCam4.visible = false
		$nealCam3.visible = false
	#kangaroos
	if (isKangarooCam3):
		$kangarooCam3.visible = true
	elif (isKangarooCam4):
		$kangarooCam4.visible = true
	
	if (alarmActiveOutside):
		if startTimer:
			startTimer = false
			$Timer.start()
		main.kangarooDeath.paused = true
	if (!alarmActiveOutside):
		$Timer.stop()
		$AudioStreamPlayer.stop()
		main.kangarooDeath.paused = false

func _on_timer_timeout() -> void:
	if (isKangarooCam3 and cam4Active):
		#print("deactivated")
		isKangarooCam3 = false
		main.kangarooActive = false
		$kangarooCam3.visible = false
		main.kangarooDeath.stop()
	elif (isKangarooCam4 and cam3Active):
		#print("deactivated")
		isKangarooCam4 = false
		main.kangarooActive = false
		$kangarooCam4.visible = false
		main.kangarooDeath.stop()
