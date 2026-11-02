class_name legs
extends Node3D

@onready var aniPlayer : AnimationPlayer = $AnimationPlayer

@export var legsProgress = 0

func _process(delta: float) -> void:
	match legsProgress:
		0:
			$AnimationPlayer.play("start")
		1:
			$AnimationPlayer.play("one")
		2:
			$AnimationPlayer.play("two")
		3:
			$AnimationPlayer.play("three")
