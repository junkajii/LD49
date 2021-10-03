extends Control

onready var audio_player := $AudioStreamPlayer

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://src/ui/menu.tscn")


func _on_ButtonClose_pressed():
	audio_player.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://src/ui/menu.tscn")
