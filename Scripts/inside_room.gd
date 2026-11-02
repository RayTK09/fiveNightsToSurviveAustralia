class_name insideRoom
extends Node3D

@onready var cam3Light : SpotLight3D = $Camera3D/SpotLight3D
@onready var cam4Light : SpotLight3D = $Camera3D2/SpotLight3D

#Im gonna do a funny
@export var cam3Active : bool = false
@export var cam4Active : bool = false
@export var isNealCam3 : bool = false
@export var isKangarooCam3 : bool = false
@export var isKangarooCam4 : bool = false
@export var alarmActiveInside : bool = false
@export var main : mainScene

var startTimer : bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (cam3Active):
		cam3Light.light_energy = 1
		$Camera3D.current = true
	else:
		cam3Light.light_energy = 0
		$Camera3D.current = false
	if (cam4Active):
		cam4Light.light_energy = 1
		$Camera3D2.current = true
	else:
		cam4Light.light_energy = 0
		$Camera3D2.current = false
	
	if (alarmActiveInside):
		$AnimationPlayer.play("blinkingLight")
	elif (!alarmActiveInside):
		$AnimationPlayer.play("RESET")
		
	if (isNealCam3):
		$nealCam3.visible = true
	else:
		$nealCam3.visible = false
	#kangaroos
	if (isKangarooCam3):
		$kangarooCam3.visible = true
	elif (isKangarooCam4):
		$kangarooCam4.visible = true
	
	if (alarmActiveInside):
		if startTimer:
			startTimer = false
			$Timer.start()
	if (!alarmActiveInside):
		$Timer.stop()
		main.kangarooDeath.paused = false
		$AudioStreamPlayer.stop()


func _on_timer_timeout() -> void:
	if (isKangarooCam3 and cam3Active):
		#print("deactivated")
		isKangarooCam3 = false
		main.kangarooActive = false
		main.hasCharacterMoved = true
		$kangarooCam3.visible = false
		main.kangarooDeath.stop()
	elif (isKangarooCam4 and cam4Active):
		#print("deactivated")
		isKangarooCam4 = false
		main.kangarooActive = false
		main.hasCharacterMoved = true
		$kangarooCam4.visible = false
		main.kangarooDeath.stop()
