extends Node2D


onready var pause := $Pause

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if pause.visible:
			pause.hide()
		else:
			pause.show()
			
