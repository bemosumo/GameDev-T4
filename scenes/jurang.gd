extends Area2D

@export var sceneName: String = "LoseScreen2"

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/" + sceneName + ".tscn")
