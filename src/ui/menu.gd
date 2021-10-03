extends Control

onready var audio_player := $AudioStreamPlayer


func _on_ButtonPlay_pressed():
	get_tree().change_scene("res://src/levels/level_1.tscn")


func _on_ButtonCredits_pressed():
	get_tree().change_scene("res://src/ui/credits.tscn")


func _on_ButtonQuit_pressed():
	get_tree().quit()


func _on_ButtonPlay_mouse_entered():
	audio_player.play()


func _on_ButtonCredits_mouse_entered():
	audio_player.play()


func _on_ButtonQuit_mouse_entered():
	audio_player.play()
